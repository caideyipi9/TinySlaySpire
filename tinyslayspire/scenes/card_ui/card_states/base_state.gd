extends CardState

# standard state machine pattern: old exit + new enter
func enter() -> void:
	# 该模块控制最高父节点的状态，必须等到card_ui准备好
	if not card_ui.is_node_ready():
		await card_ui.ready
		
	# 防止tween动画播放太长导致base状态的卡片不能及时归位
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()
	
	card_ui.reparent_requested.emit(card_ui) # 重新父化当前卡片!!!如dragging后
	card_ui.pivot_offset = Vector2.ZERO # 旋转中心偏移量，决定鼠标和卡片的位置关系
	
	# for debug
	card_ui.Dcolor.color = Color.WEB_GREEN
	card_ui.Dstate.text = "BASE"


func exit() -> void:
	pass

# state callback
func on_input(_event: InputEvent) -> void: # 任何全局输入事件
	pass
	
	
func on_gui_input(_event: InputEvent) -> void: # gui事件（按钮、标签等）
	if _event.is_action_pressed("left_mouse"):
		# 卡牌围绕鼠标点击的位置进行变换
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
	
func on_mouse_entered() -> void: # 如进入碰撞区域时启动
	pass
	
func on_mouse_exited() -> void: # 类似上面，如退出
	pass
