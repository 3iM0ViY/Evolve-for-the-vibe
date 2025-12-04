extends Node
class_name Health

@export var max_hp: int = 100
var current_hp: int

signal died
signal took_damage(amount)
signal healed(amount)

func _ready():
	current_hp = max_hp

func take_damage(amount: int):
	current_hp -= amount
	emit_signal("took_damage", amount)
	
	if current_hp <= 0:
		current_hp = 0
		emit_signal("died")

func heal(amount: int):
	current_hp = min(current_hp + amount, max_hp)
	emit_signal("healed", amount)
