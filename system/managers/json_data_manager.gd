extends Node


func _ready():
	if OS.has_feature("JavaScript"):
		if !js_handler.setted_up: js_handler.execute_javascript_global_setup()
		
		#debug_log.dprint("loading saves...")
		if js_handler.load_value("player_data") == null: save_game()
		else: load_game()
		#debug_log.dprint("%s\nloaded." % game_data.player_data, true)
		print("%s\nloaded." % game_data.player_data)
		
		#debug_log.dprint("loading settings...")
		if js_handler.load_value("game_settings") == null: save_settings()
		else: load_settings()
		#debug_log.dprint("%s\nloaded." % game_data.game_settings, true)



func save_game(): 
	print("saving game.\n", game_data.player_data)
	js_handler.save_value("player_data", json_handler.to_json_string(game_data.player_data))
func load_game(): 
	print("loading from browser.")
	game_data.player_data = json_handler.load_json_from_browser(js_handler.load_value("player_data"))

func save_settings(): 
	js_handler.save_value("game_settings", json_handler.to_json_string(game_data.game_settings))
func load_settings(): game_data.game_settings = json_handler.load_json_from_browser(js_handler.load_value("game_settings"))
