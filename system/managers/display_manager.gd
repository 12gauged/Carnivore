extends Node


func _ready():
	print(OS.get_screen_refresh_rate())
	Engine.iterations_per_second = OS.get_screen_refresh_rate()
	print(Engine.iterations_per_second)
