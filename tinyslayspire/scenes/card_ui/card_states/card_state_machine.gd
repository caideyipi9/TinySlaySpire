# a machine that contains a chanding state
# behavior == state's behavior + state init and transition
class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardUI) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child # a map from enumState to CardState
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card # get his big father: the card

	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
# state transition
func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	if from != current_state:
		return
	
	var next_state: CardState = states[to]
	if not next_state:
		return
	
	# standard state machine pattern: old exit + new enter
	if current_state:
		current_state.exit()
		
	next_state.enter()
	current_state = next_state

# state callback
		
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	if current_state:
		current_state.on_input(_event)
	
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	if current_state:
		current_state.on_gui_input(_event)
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	if current_state:
		current_state.on_mouse_entered()
	
func on_mouse_exited() -> void: # 类似上面，如退出
	if current_state:
		current_state.on_mouse_exited()
		
