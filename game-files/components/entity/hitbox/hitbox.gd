extends Area2D
class_name Hitbox


signal hit(hurtbox: Hurtbox)
@export var damage: int = 1:
	set = set_damage,
	get = get_damage


func _ready() -> void:
	area_entered.connect(on_area_entered)


func set_damage(value: int) -> void:
	damage = value


func get_damage() -> int:
	return damage


func on_area_entered(hurtbox: Hurtbox) -> void:
	hit.emit(hurtbox)
