## CardState抽象类，定义了实际状态的枚举类型和虚函数

class_name CardState
extends Node

enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

signal transition_requested(form: CardState, to: State)

@export var state: State

var card_ui: CardUI

func enter() -> void:
	pass
	
func exit() -> void:
	pass

## 接受信号的回调函数
func on_input(_event: InputEvent) -> void:
	pass
	
func on_gui_input(_event: InputEvent) -> void:
	pass
	
func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass
