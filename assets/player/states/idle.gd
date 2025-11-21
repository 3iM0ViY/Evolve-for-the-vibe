# res://scripts/states/Idle.gd
extends BaseState

class_name IdleState

func _enter():
	print("Entering IdleState")

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		state_manager._change_state("walkstate")
	elif Input.is_action_just_pressed("jump"):
		state_manager._change_state("jumpstate")
	
