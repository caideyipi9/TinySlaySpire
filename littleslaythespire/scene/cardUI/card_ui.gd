# class_name: 静态的类名，用于给其他脚本引用
class_name CardUI
extends Control

## 重新父化信号？？？
signal reparent_requested(which_card_ui: CardUI)

## onready: _ready的语法糖，完成进入场景树后的初始化功能的修饰器
## 相当于延迟了color和state的初始化到必要的初始化时刻
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStatemachine = $CardStatemachine as CardStatemachine

func _ready() -> void:
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
