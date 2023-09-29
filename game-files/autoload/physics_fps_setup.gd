extends Node


func _ready(): 
	Engine.physics_ticks_per_second = int(DisplayServer.screen_get_refresh_rate())
