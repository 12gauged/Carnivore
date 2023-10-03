extends Area2D
class_name Drop


@export var drop_data: DropData:
	set = set_data,
	get = get_data
@export_category("Nodes")
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D


func _ready() -> void:
	if drop_data == null:
		push_warning("drop_data is null")
		return
	sprite.texture = drop_data.drop_texture
	
	
func set_data(value: DropData) -> void:
	drop_data = value


func get_data() -> DropData:
	return drop_data
