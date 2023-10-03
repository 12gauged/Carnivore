@tool
extends Sprite2D
class_name EntitySprite


@export var damage_flash_duration: float = 0.5


func _ready() -> void:
	if Engine.is_editor_hint():
		self.material = preload("res://components/entity/entity_sprite/entity_sprite_material.tres")
		return
		
		
func show_damage_flash() -> void:
	start_flashing()
	await get_tree().create_timer(damage_flash_duration).timeout
	stop_flashing()


func start_flashing() -> void:
	self.material.set_shader_parameter("flashing", true)
	
	
func stop_flashing() -> void:
	self.material.set_shader_parameter("flashing", false)
