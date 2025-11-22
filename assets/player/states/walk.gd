extends BaseState

class_name WalkState

@export var walk_speed = 300.0
@export var sprint = 600.0

@export_range(0, 1) var accelaration = 0.1 #інерція під час руху
@export_range(0, 1) var decelaration = 0.1 

func _enter():
	print("Enter WalkState")

func _physics_process(delta):
	player = state_manager.get_parent()
	
	if Input.is_action_pressed("jump"):
		state_manager._change_state($"../Jump")
	
	# --- Handle sprint
	var speed
	speed = walk_speed
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction * speed, speed * accelaration) #інерція під час руху
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, walk_speed * decelaration) #інерція під час руху
	
	player.move_and_slide()

func _handle_input(event: InputEvent) -> void:
	if not Input.is_anything_pressed():
		state_manager._change_state($"../Idle")
