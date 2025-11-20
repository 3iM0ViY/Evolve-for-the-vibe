extends BaseState

@export var jump_node: NodePath
@export var fall_node: NodePath
@export var walk_node: NodePath
@export var run_node: NodePath
@export var dash_node: NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)
@onready var dash_state: BaseState = get_node(dash_node)

func enter() -> void:
	player.velocity.x = 0

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state
	return null

func physics_process(delta: float) -> BaseState:
	player.velocity.y += player.gravity
	#player.velocity = player.move_and_slide()

	if !player.is_on_floor():
		return fall_state
	return null
