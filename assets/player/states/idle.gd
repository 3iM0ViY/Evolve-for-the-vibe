# res://scripts/states/Idle.gd
extends BaseState

class_name IdleState

@onready var debug_label = $"../../DebugLabel"
@onready var animated_sprite = $"../../AnimatedSprite2D"

@export var idle_buffer_time = 1.0
var idle_buffer_timer: float

func _enter() -> void:
	debug_label.text = "Idle state"
	idle_buffer_timer = idle_buffer_time
	pass

func _exit() -> void:
	if animated_sprite: animated_sprite.pause()
	pass

func _handle_input(event: InputEvent) -> void:
	if Input.is_action_pressed("move left") or Input.is_action_pressed("move right"):
		state_manager._change_state($"../Walk")
	elif Input.is_action_pressed("jump"):
		state_manager._change_state($"../Jump")

func _update(delta: float) -> void:
	if idle_buffer_timer > 0: #анімація спокою запускається не одразу
		idle_buffer_timer -= delta
	else:
		if animated_sprite:
			animated_sprite.play("idle")
