extends CharacterBody2D

@onready var state_manager = $StateManager

func _physics_process(delta):
	state_manager._physics_process(delta)
	move_and_slide()
