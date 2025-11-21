class_name BaseState
extends Node

var state_manager: StateManager

# Methods for children to override
func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(delta: float) -> void:
	pass

func _physics_update(delta: float) -> void:
	pass

func _handle_input(event: InputEvent) -> void:
	pass
