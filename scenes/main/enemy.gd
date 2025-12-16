extends CharacterBody2D

class_name BasicEnemy

@export var SPEED = 200.0
@export_range(0, 1) var ACCELERATION = 0.5
@export var STOP_DISTANCE := 100.0
var player: Player
var player_chase: bool = false

@onready var health: Health = $Health

@export var DAMAGE := 20
@export var ATTACK_COOLDOWN := 2.0
@export var knockback_distance = 500
var can_attack := true
@onready var attack_area: Area2D = $AttackArea
@onready var attack_cooldown: Timer = $AttackTimer


func _ready():
	health.died.connect(_on_health_died)
	health.took_damage.connect(_on_health_took_damage)
	
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_cooldown.timeout.connect(_on_attack_timer_timeout)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player_chase and player:
		var distance := position.distance_to(player.position)
		if distance > STOP_DISTANCE:
			var direction := (player.position - position).normalized()
			velocity.x = lerp(velocity.x, direction.x * SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, ACCELERATION)
	
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false


func _on_health_died() -> void:
	queue_free() # removes the instance from lvl
	pass # Replace with function body.

func _on_health_took_damage(amount: Variant) -> void:
	pass # Replace with function body.


func _on_attack_area_body_entered(body: Node2D) -> void:
	if not can_attack: #attack cooldown is checked with a timer
		return
	
	if body is Player:
		body.health.take_damage(DAMAGE)
		can_attack = false
		attack_cooldown.start()
		
		body.velocity.x += sign(body.position.x - position.x) * knockback_distance #knockback

func _on_attack_timer_timeout() -> void:
	can_attack = true
	for body in attack_area.get_overlapping_bodies():
		if body is Player:
			_on_attack_area_body_entered(body)
