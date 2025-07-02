# abstract class of card state, define states and callback functions
class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

# 状态转换信号,state需要给状态机提供的信息
# 将参数传递给指定connect的函数
signal transition_requested(from: CardState, to: State) 

@export var state: State

var card_ui: CardUI # 引用当前卡片，达到最终目的：修改当前卡片的性质

# standard state machine pattern: old exit + new enter
func enter() -> void:
	pass

func exit() -> void:
	pass

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	pass
	
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	pass
	
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
