extends Node2D
class_name DropSpawner


signal drop_spawned
signal spawned_drop_collected
@export_category("Config")
@export var spawn_radius: float = 10.0
@export_enum("once", "infinite", "on_collect") var spawn_behavior: String = "once"
@export_category("Data")
@export var drop_data: DropData
