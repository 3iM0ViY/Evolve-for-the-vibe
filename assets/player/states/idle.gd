# res://scripts/states/Idle.gd
extends BaseState

class_name IdleState

@onready var debug_label = $"../../DebugLabel"

func _enter() -> void:
	debug_label.text = "Idle state"
	pass

func _exit() -> void:
	#print("exit IdleState")
	pass

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		state_manager._change_state($"../Walk")
	elif Input.is_action_pressed("jump"):
		state_manager._change_state($"../Jump")
	
