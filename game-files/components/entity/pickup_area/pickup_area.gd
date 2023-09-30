extends Area2D
class_name PickupArea


signal drop_collected(type, resource)


func _ready() -> void:
	area_entered.connect(on_drop_collided)


func collect_drop(drop_type: String, drop_data: Resource = null) -> void:
	drop_collected.emit(drop_type, drop_data)


func on_drop_collided(drop: Drop) -> void:
	collect_drop(drop.type, drop.get_data())
	drop.queue_free()
