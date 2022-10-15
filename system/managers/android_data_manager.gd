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
		# warning-ignore:return_value_discarded
		FileManager.open(player_data_file, FileManager.READ)
		var player_data = FileManager.get_var()
		FileManager.close()
		#game_data.player_data = compare_dictionaries(game_data.default_player_data, player_data)
		game_data.call_deferred("override_player_data", compare_dictionaries(player_data, game_data.default_player_data))
	else: save_player_data()
		
	if FileManager.file_exists(settings_file):
		# warning-ignore:return_value_discarded
		FileManager.open(settings_file, FileManager.READ)
		var game_settings = FileManager.get_var()
		FileManager.close()
		#game_data.game_settings = compare_dictionaries(game_data.default_game_settings, game_settings)
		game_data.call_deferred("override_game_settings", compare_dictionaries(game_settings, game_data.default_game_settings))
	else: save_settings()
		

func check_dir():
	var DirectoryManager: Directory = Directory.new()
	
	if !DirectoryManager.dir_exists(save_dir):
		# warning-ignore:return_value_discarded
		DirectoryManager.make_dir(save_dir)
		
		
func save_settings():
	var FileManager: File = File.new()
	check_dir()
	
	# warning-ignore:return_value_discarded
	FileManager.open(settings_file, FileManager.WRITE)
	FileManager.store_var(game_data.game_settings)
	FileManager.close()
	debug_log.call_deferred("dprint", "saving settings.")
	
func save_player_data():
	var FileManager: File = File.new()
	check_dir()
	# warning-ignore:return_value_discarded
	FileManager.open(player_data_file, FileManager.WRITE)
	FileManager.store_var(game_data.player_data)
	FileManager.close()
	debug_log.call_deferred("dprint", "saving player_data.")
		
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
	
