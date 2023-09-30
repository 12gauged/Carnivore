extends Node2D
class_name Projectile


@export var speed: int = 1
@export var hurtbox: Hitbox
var direction: Vector2:
	set = set_direction,
	get = get_direction


func _physics_process(delta):
	if direction == Vector2.ZERO:
		push_error("direction is Vector2.ZERO")
		set_physics_process(false)
		return
	if not direction.is_normalized():
		push_warning("direction not normalized")
	self.global_position += direction * speed * delta
	
	
func set_direction(value: Vector2) -> void:
	direction = value
	
	
func get_direction() -> Vector2:
	return direction
