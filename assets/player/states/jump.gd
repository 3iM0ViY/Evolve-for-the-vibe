extends BaseState

class_name JumpState

@export var jump_strength = -600
@export_range(0, 1) var jump_decelaration_on_release = 0.1
@export var jump_buffer_time = 0.1 #на стрибок є невеличкий буфер якщо користувач натиснув ще в повітрі
var jump_buffer_timer: float = 0.1

@export_range(0, 1) var coyote_time = 0.1
var coyote_timer: float = 0

func _enter() -> void:
	#print("Enter JumpState")
	player = state_manager.get_parent()

func _physics_process(delta: float) -> void:
	if player:
		# --- Handle jump.
		if Input.is_action_just_pressed("jump"):
			jump_buffer_timer = jump_buffer_time
		if jump_buffer_timer > 0:
			jump_buffer_timer -= delta
		
		# Coyote time
		if player.is_on_floor():
			coyote_timer = coyote_time
		else:
			if coyote_timer > 0:
				coyote_timer -= delta
		
		if jump_buffer_timer > 0 and (player.is_on_floor() or coyote_timer > 0): #на стрибок є невеличкий буфер якщо користувач натиснув в повітрі
			player.velocity.y = jump_strength
			jump_buffer_timer = 0
			coyote_timer = 0
		
		if Input.is_action_just_released("jump") and player.velocity.y < 0: #бінди знаходяться в налаштуваннях проєкту => input map
			player.velocity.y *= jump_decelaration_on_release #коротший стрибок, якщо не затискати пробіл
		
		if player.is_on_floor():
			if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
				state_manager._change_state($"../Walk")
			if not Input.is_anything_pressed():
				state_manager._change_state($"../Idle")

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("dash"):
		state_manager._change_state($"../Dash")
