@tool
extends Sprite2D
class_name RandomSprite


@export var SpriteList: Array[Texture] = []:
	set = set_sprite_list
@export var chosen_sprite: Texture
	
	
func _ready() -> void:
	if not Engine.is_editor_hint(): 
		self.texture = chosen_sprite
		return
	set_random_texture()


func set_sprite_list(value: Array[Texture]) -> void:
	if not Engine.is_editor_hint(): return
	
	SpriteList = value
	if SpriteList.is_empty(): return
	set_random_texture()


func set_random_texture() -> void:
	randomize()
	var sprite_id = randi_range(0, len(SpriteList) - 1)
	self.texture = SpriteList[sprite_id]
	chosen_sprite = self.texture

