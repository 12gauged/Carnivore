extends Control

var SCREEN_SIZE = OS.get_window_size()


func _ready():
	self.rect_pivot_offset.x = SCREEN_SIZE.x / 2
#	self.rect_pivot_offset.y = SCREEN_SIZE.y / 2
	print(self.rect_pivot_offset, "\n", SCREEN_SIZE, "\n")
