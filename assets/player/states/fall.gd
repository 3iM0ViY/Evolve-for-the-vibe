extends BaseState

class_name FallState

@export var max_fall_speed := 900.0

func _enter() -> void:
	debug_label.text = "Fall state"
	player = state_manager.get_parent()

func _physics_process(delta: float) -> void:
	if player:
		if player.velocity.y > max_fall_speed: #максимальна швидкість падіння
			player.velocity.y = max_fall_speed

func _handle_input(event: InputEvent) -> void:
	if player.is_on_ground() or player.is_on_floor():
		if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
			state_manager._change_state($"../Walk")
		if not Input.is_anything_pressed():
			state_manager._change_state($"../Idle")
	if Input.is_action_just_pressed("dash"):
		state_manager._change_state($"../Dash")
