extends CharacterBody2D


signal deleted


func die() -> void:
	delete()


func delete() -> void:
	deleted.emit()
	queue_free()
