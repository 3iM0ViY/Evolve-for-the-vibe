extends BaseState

class_name JumpState

@export var jump_strength = -600
@export_range(0, 1) var jump_decelaration_on_release = 0.1
@export var jump_buffer_time = 0.1 #на стрибок є невеличкий буфер якщо користувач натиснув ще в повітрі
var jump_buffer_timer: float = 0.1

@export_range(0, 1) var coyote_time = 0.1
var coyote_timer: float = 0

func _enter() -> void:
	print("Enter JumpState")
	player = state_manager.get_parent()

func _physics_process(dalta: float) -> void:
	if Input.is_action_just_released("jump"): #бінди знаходяться в налаштуваннях проєкту => input map
		player.velocity.y *= jump_decelaration_on_release #коротший стрибок, якщо не затискати пробіл
	
	if player:
		if player.is_on_floor():
			pass
