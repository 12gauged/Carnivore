extends Node2D
class_name Projectile

export(int) var speed = 10
export(Array) var TAGS = []
export(int) var max_lifetime = 60

onready var hitbox = $part_hitbox
var direction: Vector2 = Vector2.ZERO setget set_direction
var lifetime: int = 0

func _physics_process(delta):
	global_position += direction * (speed * delta)
	if lifetime >= max_lifetime:
		queue_free()
	else:
		lifetime += 1
	
func set_direction(value: Vector2): direction = value.normalized()
func set_speed(value: int): speed = value

func set_hitbox_tags(tags: Array):
	hitbox.TAGS = tags

