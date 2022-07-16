extends Node


func _ready():
	if OS.has_feature("JavaScript"):
		if !js_handler.setted_up: js_handler.execute_javascript_global_setup()
		
		if js_handler.load_value("player_data") == null: save_game()
		else: load_game()
		print("%s\nloaded." % game_data.player_data, true)

		if js_handler.load_value("game_settings") == null: save_settings()
		else: load_settings()
		print("%s\nloaded." % game_data.game_settings, true)



func save_game(): js_handler.save_value("player_data", json_handler.to_json_string(game_data.player_data))
func load_game(): 
	var loaded_values = json_handler.load_json_from_browser(js_handler.load_value("player_data")).duplicate()
	loaded_values = compare_dictionaries(loaded_values, game_data.player_data)
	game_data.player_data = loaded_values

func save_settings(): js_handler.save_value("game_settings", json_handler.to_json_string(game_data.game_settings))
func load_settings(): 
	var loaded_values = json_handler.load_json_from_browser(js_handler.load_value("game_settings"))
	loaded_values = compare_dictionaries(loaded_values, game_data.game_settings)
	game_data.game_settings = loaded_values


func compare_dictionaries(dir1, dir2):
	for value in dir2.keys():
		match dir2[value] is Dictionary:
			true:
				for subvalue in dir2[value].keys():
					if !subvalue in dir2[value].keys():
						print("%s/%s not present in the loaded values. adding it in..." % [value, subvalue])
						dir1[value][subvalue] = dir2[value][subvalue]
			false:
				if !value in dir1.keys():
					print("%s not present in the loaded values. adding it in..." % value)
					dir1[value] = dir2[value]
	print("\n")
	return dir1
