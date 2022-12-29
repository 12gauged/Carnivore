extends Node


func _ready():
	self.visible = OS.is_debug_build()
