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
	if new_state == current_state:
		return
	
	if not new_state:
		push_warning("Нема такого стану!")
		return
	
	var index := states.find(new_state)
	if index == -1:
		push_error("Стан '%s' не збережено тут!" % new_state.name)
		return
	
	current_state = states[index] # Обираєм ноду нового стану по індексу в списку станів
	current_state._enter()
	#current_state.debug_label.text = current_state.to_string()
