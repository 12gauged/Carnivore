extends Node


var current_data_manager: String
var data_managers: Dictionary = {
	"json": json_data_manager,
	"android": android_data_manager
}


func _ready():
	var OS_name: String = OS.get_name()
	
	debug_log.call_deferred("dprint", "working with %s\ndevice is set to: %s" % [OS_name, game_data.current_platform])
	
	match OS_name:
		"Android": current_data_manager = "android"
		_: current_data_manager = "json"
		
	data_managers[current_data_manager].setup()



func save_player_data(): data_managers[current_data_manager].save_player_data()

func save_settings(): data_managers[current_data_manager].save_settings()


func save_all():
	save_settings()
	save_player_data()
