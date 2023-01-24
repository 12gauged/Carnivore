extends Node


const GAME_SETTINGS_LOCALIZATION = "12GAUGED.CARNIVORE:game_settings"
const PLAYER_DATA_LOCALIZATION = "12GAUGED.CARNIVORE:player_data"


func setup():
	if !js_handler.setted_up: js_handler.execute_javascript_global_setup()
	
	debug_log.call_deferred("dprint", "json_data_manager.gd: loading from browser")
	
	if js_handler.load_value(PLAYER_DATA_LOCALIZATION) == null: 
		print("json_data_manager.gd: No player data found. Generating new save...")
		save_player_data()
	else: 
		print("json_data_manager.gd: Player data found. Loading...")
		load_game()

	if js_handler.load_value(GAME_SETTINGS_LOCALIZATION) == null:
		print("json_data_manager.gd: No game settings found. Starting with default settings...")
		save_settings()
	else: 
		print("json_data_manager.gd: Game settings found. Loading...")
		load_settings()
	
	var current_locale = game_data.get_game_setting("locale", "value")
	print("json_data_manager.gd: Loaded localization: %s" % current_locale)
	if current_locale != "DEFAULT":
		TranslationServer.set_locale(current_locale)


func save_player_data(): js_handler.save_value(PLAYER_DATA_LOCALIZATION, json_handler.to_json_string(game_data.player_data))
func load_game(): 
	var loaded_values = json_handler.load_json_from_browser(js_handler.load_value(PLAYER_DATA_LOCALIZATION)).duplicate()
	#game_data.player_data = compare_dictionaries(game_data.default_player_data, loaded_values)
	game_data.override_player_data(compare_dictionaries(game_data.default_player_data, loaded_values))

func save_settings(): js_handler.save_value(GAME_SETTINGS_LOCALIZATION, json_handler.to_json_string(game_data.game_settings))
func load_settings(): 
	var loaded_values = json_handler.load_json_from_browser(js_handler.load_value(GAME_SETTINGS_LOCALIZATION))
	var formatted_values = compare_dictionaries(loaded_values, game_data.default_game_settings)
	game_data.override_game_settings(formatted_values)
	print("json_data_manager.gd: loaded_values: %s" % loaded_values)
	print("json_data_manager.gd: formatted_values: %s" % formatted_values)
	
func save_all():
	print("json_data_manager.gd: Saving...")
	save_settings()
	save_player_data()
	
func compare_dictionaries(dir1, dir2):
	for value in dir2.keys():
		match dir2[value] is Dictionary:
			true:
				for subvalue in dir2[value].keys():
					if !subvalue in dir1[value].keys():
						print("json_data_manager.gd: %s/%s not present in the loaded values. adding it in..." % [value, subvalue])
						dir1[value][subvalue] = dir2[value][subvalue]
			false:
				if !value in dir1.keys():
					print("json_data_manager.gd: %s not present in the loaded values. adding it in..." % value)
					dir1[value] = dir2[value]
	print("json_data_manager.gd: \n")
	return dir1

