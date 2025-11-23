extends BaseState

class_name DashState

@export var dash_speed = 1000.0
@export var dash_max_distance = 300
@export var dash_curve : Curve
@export var dash_cooldown = 1.0

var is_in_dash = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	#print("Enter DashState")
	player = state_manager.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player:
		var direction := Input.get_axis("move left", "move right")
		# Dashing
		if Input.is_action_just_pressed("dash") and direction and not is_in_dash and dash_timer <= 0:
			is_in_dash = true
			dash_start_position = player.position.x
			dash_direction = direction
			dash_timer = dash_cooldown
		
		if is_in_dash:
			var current_distance = abs(player.position.x - dash_start_position)
			if current_distance >= dash_max_distance or player.is_on_wall():
				is_in_dash = false
			else:
				player.velocity.x = direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance) #деш, прив'язаний до кривої з інспектора
				player.velocity.y = 0 #щоб не падати в моменті (луні тюнс момент)
		
		if dash_timer > 0:
			dash_timer -= delta #час рахуєтсья в кадрах
		
func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		state_manager._change_state($"../Walk")
	elif Input.is_action_pressed("jump"):
			state_manager._change_state($"../Jump")
	if not Input.is_anything_pressed():
		state_manager._change_state($"../Idle")
