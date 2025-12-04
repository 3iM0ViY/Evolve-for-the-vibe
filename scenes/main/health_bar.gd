extends ProgressBar

@export var player: Player

func _ready() -> void:
	player.health.took_damage.connect(_on_took_damage)
	player.health.healed.connect(_on_healed)
	_update()

func _on_took_damage(amount: int) -> void:
	_update()

func _on_healed(amount: int) -> void:
	_update()

func _update():
	var hp = player.health.current_hp * 100 / player.health.max_hp
	if hp >= 0:
		value = hp
	else:
		value = 0
