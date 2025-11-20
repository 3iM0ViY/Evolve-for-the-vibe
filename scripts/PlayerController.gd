extends CharacterBody2D

@export var walk_speed = 300.0
@export var sprint = 600.0

@export_range(0, 1) var accelaration = 0.1 #інерція під час руху
@export_range(0, 1) var decelaration = 0.1 

@export var jump_strength = -600
@export_range(0, 1) var jump_decelaration_on_release = 0.1
@export var jump_buffer_time = 0.1 #на стрибок є невеличкий буфер якщо користувач натиснув ще в повітрі
var jump_buffer_timer: float = 0.1

@export var dash_speed = 1000.0
@export var dash_max_distance = 300
@export var dash_curve : Curve
@export var dash_cooldown = 1.0

var is_in_dash = false
var dash_start_position = 0
var dash_direction = 0
var dash_timer = 0

@export var coyote_time = 0.1
var coyote_timer: float = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta #можна змінити в налаштуваннях проєкту => physics => 2d
		#velocity += Vector2(0, 9.81)

	# --- Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	# Coyote time
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		if coyote_timer > 0:
			coyote_timer -= delta
	
	if jump_buffer_timer > 0 and (is_on_floor() or coyote_timer > 0): #на стрибок є невеличкий буфер якщо користувач натиснув в повітрі
		velocity.y = jump_strength
		jump_buffer_timer = 0
		coyote_timer = 0
	
	if Input.is_action_just_released("jump") and velocity.y < 0: #бінди знаходяться в налаштуваннях проєкту => input map
		velocity.y *= jump_decelaration_on_release #коротший стрибок, якщо не затискати пробіл
	
	# --- Handle sprint
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
	
	# Dashing
	if Input.is_action_just_pressed("dash") and direction and not is_in_dash and dash_timer <= 0:
		is_in_dash = true
		dash_start_position = position.x
		dash_direction = direction
		dash_timer = dash_cooldown
	
	if is_in_dash:
		var current_distance = abs(position.x - dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall():
			is_in_dash = false
		else:
			velocity.x = direction * dash_speed * dash_curve.sample(current_distance / dash_max_distance) #деш, прив'язаний до кривої з інспектора
			velocity.y = 0 #щоб не падати в моменті (луні тюнс момент)
	
	if dash_timer > 0:
		dash_timer -= delta #час рахуєтсья в кадрах
	
	move_and_slide()
