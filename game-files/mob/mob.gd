extends CharacterBody2D
class_name Mob


signal deleted


func die() -> void:
	delete()


func delete() -> void:
	deleted.emit()
	queue_free()
