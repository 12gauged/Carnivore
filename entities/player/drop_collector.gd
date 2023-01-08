extends Area2D


onready var Collision: CollisionShape2D = $CollisionShape2D


func _ready():
	if not game_data.player_data.skills.extended_tongue: return
	Collision.shape.radius = 12
