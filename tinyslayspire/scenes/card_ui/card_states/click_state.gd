extends CardState

# standard state machine pattern: old exit + new enter
func enter() -> void:
	# 开始检测碰撞区域
	card_ui.drop_point_detector.monitoring = true
	
	# for debug
	card_ui.Dcolor.color = Color.ORANGE
	card_ui.Dstate.text = "CLICK"

func exit() -> void:
	pass

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	if _event is InputEventMouseMotion:
		transition_requested.emit(self,  CardState.State.DRAGGING)
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	pass
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
