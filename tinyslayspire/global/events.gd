# 全局消息系统

extends Node

# Card-related Events
# 为什么将瞄准信号放在总线事件系统上：跨对象信号，减少冒泡传递
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
 
