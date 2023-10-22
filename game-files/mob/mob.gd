extends CharacterBody2D
class_name Mob


signal deleted
signal spawned


func die() -> void:
	delete()
	
	
func spawn() -> void:
	spawned.emit()


func delete() -> void:
	deleted.emit()
	queue_free()
