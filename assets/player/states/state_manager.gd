extends Node
class_name StateManager

@export var initial_state: BaseState
var current_state: BaseState 
var states: Array = []

func _ready() -> void:
	#register child states
	for child in get_children():
		if child is BaseState:
			states.append(child)
			child.state_manager = self
	
	#start with initial state
	if initial_state:
		_change_state(initial_state)

func _process(delta: float) -> void:
	if current_state:
		current_state._update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_process(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state._handle_input(event)

func _change_state(new_state: BaseState) -> void:
	if current_state:
		current_state._exit()
	
	#print(states)
	#print(new_state)
	current_state = states[states.find(new_state)] # Обираєм ноду нового стану по індексу в списку станів
	
	if current_state:
		current_state._enter()
