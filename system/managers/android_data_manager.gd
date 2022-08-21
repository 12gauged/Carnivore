extends Node

const save_dir: String = "user://saves/"
const player_data_file: String = save_dir + "player_data.save"
const settings_file: String = save_dir + "settings.save"


func setup():
	debug_log.call_deferred("dprint", "loading on android")
	load_game()
	
	var current_locale = game_data.get_game_setting("locale", "value")
	if current_locale != "DEFAULT":
		TranslationServer.set_locale(current_locale)



func load_game():
	var FileManager: File = File.new()
	if FileManager.file_exists(player_data_file):
		FileManager.open(player_data_file, FileManager.READ)
		var player_data = FileManager.get_var()
		FileManager.close()
		game_data.player_data = player_data
	else: save_player_data()
		
	if FileManager.file_exists(settings_file):
		FileManager.open(settings_file, FileManager.READ)
		var game_settings = FileManager.get_var()
		FileManager.close()
		game_data.game_settings = game_settings
	else: save_settings()
		

func check_dir():
	var DirectoryManager: Directory = Directory.new()
	
	if !DirectoryManager.dir_exists(save_dir):
		DirectoryManager.make_dir(save_dir)
		
		
func save_settings():
	var FileManager: File = File.new()
	check_dir()
	
	FileManager.open(settings_file, FileManager.WRITE)
	FileManager.store_var(game_data.game_settings)
	FileManager.close()
	debug_log.call_deferred("dprint", "saving settings.")
	
func save_player_data():
	var FileManager: File = File.new()
	check_dir()
	FileManager.open(player_data_file, FileManager.WRITE)
	FileManager.store_var(game_data.player_data)
	FileManager.close()
	debug_log.call_deferred("dprint", "saving player_data.")
		
func save_all():
	save_settings()
	save_player_data()
	
