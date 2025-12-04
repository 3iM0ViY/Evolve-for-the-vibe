extends BaseState

class_name DeadState

func _enter():
	player = state_manager.get_parent()
	debug_label.text = "Press R to restart\nDead state"
	player.velocity = Vector2.ZERO
	player.set_process(false)
	player.set_physics_process(false)

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("restart"):
		get_tree().call_deferred("reload_current_scene")
