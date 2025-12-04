extends Area2D

class_name Spikes

@export var player: Player

@export var spikes_damage = 100

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player.health.take_damage(spikes_damage)
