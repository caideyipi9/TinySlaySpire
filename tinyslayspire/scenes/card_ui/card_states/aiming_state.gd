extends CardState

const MOUSE_Y_SNAPBAKC_THRESHOLD := 138

# standard state machine pattern: old exit + new enter
func enter() -> void:
	# for debug
	card_ui.Dcolor.color = Color.WEB_GREEN
	card_ui.Dstate.text = "BASE"
	
	# 既然是“瞄准”，前面的目标自然全部失效
	card_ui.targets.clear()
	
	# 进入瞄准状态的演示动画：将卡片移动到手牌去正上方
	var offset := Vector2(card_ui.parent.size.x / 2, -card_ui.size.y / 2)
	offset.x -= card_ui.size.x / 2
	card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.2)
	card_ui.drop_point_detector.monitoring = false
	
	# 触发事件总线上的开始瞄准信号
	Events.card_aim_started.emit(card_ui)


func exit() -> void:
	Events.card_aim_ended.emit(card_ui) 

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	var mouse_motion :=  _event is InputEventMouseMotion
	var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBAKC_THRESHOLD
	var confirm = _event.is_action_released("left_mouse") or _event.is_action_pressed("left_mouse")
		
	if (mouse_motion and mouse_at_bottom) or _event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled() # 标记输入为已处理，防止意外拾取新卡片
		transition_requested.emit(self, CardState.State.RELEASED)
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	pass
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
