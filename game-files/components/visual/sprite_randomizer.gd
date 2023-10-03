extends Sprite2D
class_name RandomSprite


@export var SpriteList: Array[Texture] = []
	
	
func _ready() -> void:
	set_random_texture()


func set_random_texture() -> void:
	randomize()
	var sprite_id = randi_range(0, len(SpriteList) - 1)
	self.texture = SpriteList[sprite_id]

