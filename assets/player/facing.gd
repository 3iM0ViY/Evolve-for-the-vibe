class_name Facing
extends Node

var facing_dir: int = 1  # 1 = right, -1 = left

@export var sprite_path: NodePath
var sprite: Node2D

func _ready():
	sprite = get_node(sprite_path)

func update_facing(input_dir: float) -> void:
	if input_dir == 0:
		return
		
	if input_dir > 0:
		facing_dir = 1
	else:
		facing_dir = -1

	sprite.scale.x = facing_dir
