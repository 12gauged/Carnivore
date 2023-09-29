extends Area2D
class_name Hitbox


signal hit(hurtbox: Hurtbox)
@export var damage: int = 1


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(hurtbox: Hurtbox) -> void:
	hit.emit(hurtbox)
