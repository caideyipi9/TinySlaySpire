class_name Card
extends Resource

enum Type {ATTACK, DEFEND, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attrs")
@export var id: String
@export var type: Type
@export var target: Target

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY
