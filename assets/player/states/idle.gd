# res://scripts/states/Idle.gd
extends BaseState

class_name IdleState

func _enter() -> void:
	print("Entering IdleState")

func _exit() -> void:
	print("exit IdleState")

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		state_manager._change_state($"../Walk")
	elif Input.is_action_pressed("jump"):
		state_manager._change_state($"../Jump")
	
