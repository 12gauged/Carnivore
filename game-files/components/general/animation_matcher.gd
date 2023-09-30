@tool
extends Sprite2D


@export var Parent: Sprite2D


func _process(_delta):
	if not is_instance_valid(Parent): return
	
	self.hframes = Parent.hframes
	self.vframes = Parent.vframes
	self.frame = Parent.frame


