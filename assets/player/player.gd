extends CharacterBody2D

@onready var state_manager = $StateManager
@onready var player = state_manager.get_parent()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #можна змінити в налаштуваннях проєкту => physics => 2d
	state_manager._physics_process(delta)
	move_and_slide()
