extends Area2D
class_name Hurtbox


signal hurt(hitbox)


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(hitbox: Hitbox) -> void:
	hurt.emit(hitbox)
