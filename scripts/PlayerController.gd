extends CharacterBody2D

@export var walk_speed = 300.0
@export var sprint = 600.0

@export_range(0, 1) var accelaration = 0.1 #інерція під час руху
@export_range(0, 1) var decelaration = 0.1 

@export var jump_strength = -800
@export_range(0, 1) var jump_decelaration_on_release = 0.1
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #можна змінити в налаштуваннях проєкту => physics => 2d
		#velocity += Vector2(0, 9.81)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor(): #бінди знаходяться в налаштуваннях проєкту => input map
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= jump_decelaration_on_release #коротший стрибок, якщо не затискати пробіл
	
	var speed
	if Input.is_action_pressed("sprint"):
		speed = sprint
	else:
		speed = walk_speed
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * accelaration) #інерція під час руху
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * decelaration) #інерція під час руху

	move_and_slide()
