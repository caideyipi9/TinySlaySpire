extends CardState

const DRAG_MINIMUN_THRESHOLD := 0.05

var minimum_drag_time_elapsed := false

# standard state machine pattern: old exit + new enter
func enter() -> void:
	# 将卡片父化到BattleUI下，脱离Hand的控制
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
		
	# 用于处理鼠标过快点击的定时器,设置一个最小拖拽时间
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUN_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
	# for debug
	card_ui.Dcolor.color = Color.NAVY_BLUE
	card_ui.Dstate.text = "DRAGGING"

func exit() -> void:
	pass

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	var mouse_motion :=  _event is InputEventMouseMotion
	var cancel  = _event.is_action_pressed("right_mouse")
	var confirm = _event.is_action_released("left_mouse") or _event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and  confirm:
		get_viewport().set_input_as_handled() # 标记输入为已处理，防止意外拾取新卡片
		transition_requested.emit(self, CardState.State.RELEASED)
		
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	pass
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
