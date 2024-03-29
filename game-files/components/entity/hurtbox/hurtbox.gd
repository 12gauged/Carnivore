extends Area2D
class_name Hurtbox


signal hurt(damage: int)
signal hitbox_collided(hitbox: Hitbox)
signal collided
@export var ignore_groups: Array[String]


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(hitbox: Hitbox) -> void:
	for group in hitbox.get_groups():
		if group in ignore_groups: 
			return
	hurt.emit(hitbox.damage)
	hitbox_collided.emit(hitbox)
	collided.emit()
	
	if hitbox.destroy_when_hit:
		hitbox.parent.queue_free()
	
	
func add_ignore_group(group) -> void:
	ignore_groups.append(group)
