extends CardState

var played: bool

# standard state machine pattern: old exit + new enter
func enter() -> void:
	# for debug
	card_ui.Dcolor.color = Color.DARK_VIOLET
	card_ui.Dstate.text = "RELEASING"
	
	played = false
	
	if not card_ui.targets.is_empty():
		played = true
		
		# for debug
		print("play card for target:", card_ui.targets)

func exit() -> void:
	pass

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	if played:
		return 
	
	transition_requested.emit(self, CardState.State.BASE)
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	pass
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
