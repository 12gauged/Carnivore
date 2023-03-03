extends Node


func _ready():
	Engine.iterations_per_second = int(OS.get_screen_refresh_rate())
	print("display_manager.gd: Working at %shz. Physics FPS is set to %s" % [OS.get_screen_refresh_rate(), Engine.iterations_per_second])
