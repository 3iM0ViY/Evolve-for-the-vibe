extends Node
class_name Health

@export var max_hp: int = 100
var current_hp: int

@export var invincibility_time = 1.0
var is_invincible = false
var invincibility_timer = 0.0

signal died
signal took_damage(amount)
signal healed(amount)

func _ready():
	current_hp = max_hp

func take_damage(amount: int):
	if is_invincible:
		return
	
	current_hp -= amount
	print(current_hp)
	emit_signal("took_damage", amount)
	is_invincible = true
	invincibility_timer = invincibility_time
	
	if current_hp <= 0:
		current_hp = 0
		emit_signal("died")

func _process(delta):
	if is_invincible:
		invincibility_timer -= delta
		if invincibility_timer <= 0:
			is_invincible = false

func heal(amount: int):
	current_hp = min(current_hp + amount, max_hp)
	emit_signal("healed", amount)
