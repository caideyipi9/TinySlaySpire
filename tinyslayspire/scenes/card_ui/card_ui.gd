class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI) # 状态可以重新父化卡片，防止受限于Hand框内

@export var card: Card

@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

@onready var Dcolor: ColorRect = $DColor
@onready var Dstate: Label = $DState

@onready var targets: Array[Node] = [] # 存储当前卡片的所有目标,如碰撞区域、敌人等

var parent: Control
var tween: Tween

func _ready() -> void:
	card_state_machine.init(self)

# state callback
		
func _input(event: InputEvent) -> void: # 任何全局输入事件,使用内置回调函数
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void: # gui事件（按钮、标签等）
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void: # 如进入碰撞区域时启动
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void: # 类似上面，如退出
	card_state_machine.on_mouse_exited()
		
# 碰撞检测
func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	if targets.has(area):
		targets.erase(area)
		
func animate_to_position(next_pos: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", next_pos, duration)
