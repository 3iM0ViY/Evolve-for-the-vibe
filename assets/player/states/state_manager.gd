extends Node
class_name StateManager

@export var initial_state: BaseState
var current_state: BaseState 
var states: Dictionary = {}

func _ready() -> void:
	#register child states
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.state_manager = self
	
	#start with initial state
	if initial_state:
		_change_state(initial_state.name.to_lower())

func _process(delta: float) -> void:
	if current_state:
		current_state._update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_process(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state._handle_input(event)

func _change_state(new_state_name: String) -> void:
	if current_state:
		current_state._exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state._enter()
