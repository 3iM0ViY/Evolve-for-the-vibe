extends CharacterBody2D

@onready var state_manager = $StateManager
@onready var player = state_manager.get_parent()

func _physics_process(delta):
	state_manager._physics_process(delta)
	move_and_slide()
