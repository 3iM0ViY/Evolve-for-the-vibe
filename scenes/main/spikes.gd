extends Area2D

class_name Spikes

@onready var player = $"../../Player"


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.health.take_damage(100)
		print(player.health.current_hp)
