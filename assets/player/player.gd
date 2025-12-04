extends CharacterBody2D

class_name Player

@onready var state_manager = $StateManager
@onready var player = state_manager.get_parent()
@onready var facing: Facing = $Facing #глобальна зміна напрямку руху персонажа

@onready var health: Health = $Health

@onready var floor_detector = $Sensors/FloorDetect
@onready var wall_left_detector = $Sensors/WallLeft
@onready var wall_right_detector = $Sensors/WallRight

func _ready():
	health.died.connect(_on_health_died)
	#health.took_damage.connect(_on_damage_taken)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #можна змінити в налаштуваннях проєкту => physics => 2d
	state_manager._physics_process(delta)
	move_and_slide()

func is_on_ground() -> bool:
	return floor_detector.is_colliding()

func is_touching_wall_left() -> bool:
	return wall_left_detector.is_colliding()

func is_touching_wall_right() -> bool:
	return wall_right_detector.is_colliding()

func wall_normal() -> Vector2:
	if is_touching_wall_left():
		return Vector2.RIGHT
	if is_touching_wall_right():
		return Vector2.LEFT
	return Vector2.ZERO


func _on_health_died() -> void:
	state_manager._change_state($StateManager/Dead)
