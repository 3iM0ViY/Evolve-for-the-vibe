extends Node2D

@onready var health: Health = $"../Health"
@onready var bar: ProgressBar = $ProgressBar

func _ready() -> void:
	bar.min_value = 0
	bar.max_value = health.max_hp
	bar.value = health.current_hp
	
	#bar.visible = health.current_hp < health.max_hp #health invisble before a hit
	
	health.took_damage.connect(_update)
	health.healed.connect(_update)
	health.died.connect(_on_died)

func _process(_delta: float) -> void:
	pass

func _update(_amount := 0) -> void:
	bar.value = health.current_hp
	
	#pop animation
	bar.scale = Vector2(1.2, 1.2)
	bar.scale = bar.scale.lerp(Vector2.ONE, 0.2)


func _on_died() -> void:
	queue_free()
