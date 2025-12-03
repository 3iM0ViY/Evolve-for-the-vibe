extends BaseState

class_name WalkState

@export var walk_speed = 300.0
@export var sprint = 600.0

@export_range(0, 1) var accelaration = 0.1 #інерція під час руху
@export_range(0, 1) var decelaration = 0.1 

@onready var debug_label = $"../../DebugLabel"

func _enter():
	debug_label.text = "Walk state"
	player = state_manager.get_parent()

func _physics_process(delta):
	if player:
		if Input.is_action_pressed("jump"):
			state_manager._change_state($"../Jump")
		
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
			player.velocity.x = move_toward(player.velocity.x, direction * speed, speed * accelaration) #інерція під час руху
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, walk_speed * decelaration) #інерція під час руху

func _handle_input(event: InputEvent) -> void:
	if not Input.is_anything_pressed():
		state_manager._change_state($"../Idle")
	if Input.is_action_just_pressed("dash"):
		state_manager._change_state($"../Dash")
