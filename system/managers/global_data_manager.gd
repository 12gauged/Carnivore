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
	var updated_game_settings = compare_dictionaries(game_data.game_settings, game_data.default_game_settings)
	var updated_player_data = compare_dictionaries(game_data.player_data, game_data.default_player_data)
	game_data.game_settings = updated_game_settings
	game_data.player_data = updated_player_data



func save_player_data(): data_managers[current_data_manager].save_player_data()
func save_settings(): data_managers[current_data_manager].save_settings()


func save_all():
	save_settings()
	save_player_data()
	
	
func compare_dictionaries(dir1, dir2):
	for value in dir2.keys():
		match dir2[value] is Dictionary:
			true:
				for subvalue in dir2[value].keys():
					if !subvalue in dir1[value].keys():
						print("%s/%s not present in the loaded values. adding it in..." % [value, subvalue])
						dir1[value][subvalue] = dir2[value][subvalue]
			false:
				if !value in dir1.keys():
					print("%s not present in the loaded values. adding it in..." % value)
					dir1[value] = dir2[value]
	print("\n")
	return dir1
