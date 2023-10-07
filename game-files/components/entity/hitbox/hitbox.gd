extends Area2D
class_name Hitbox


signal hit(hurtbox: Hurtbox)
@export var parent: Projectile
@export var damage: int = 1:
	set = set_damage,
	get = get_damage
var destroy_when_hit: bool = false:
	set = set_destroy_when_hit


func _ready() -> void:
	area_entered.connect(on_area_entered)


func set_damage(value: int) -> void:
	damage = value


func get_damage() -> int:
	return damage
	
	
func set_destroy_when_hit(value: bool) -> void:
	destroy_when_hit = value


func on_area_entered(hurtbox: Hurtbox) -> void:
	hit.emit(hurtbox)
