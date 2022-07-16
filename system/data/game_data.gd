extends Node

const ARCHIEVEMENT_REF: Dictionary = {
	"generation0": {
		0: "village_savior", ## Save the village
		1: "full_belly", ## Eat 5 or more enemies on a row 
		2: "triple_kill" ## Kill 3 enemies with a single shot
	},
	"generation1": {
		0: "ant_on_a_stick", ## Make an ant soldier impale 3 or more enemies
		1: "accidental_punch", ## Make a worm kill another enemy
		2: "friendly_fire" ## Make a frog kill an ant soldier
	},
	"generation2": {
		0: "gotcha", # Kill a fire ant before it explodes
		1: "not_so_wet", # Use fire to kill a frog
		2: "secret_weapon" # Use a frog to kill all enemies in a wave
	}
}

var player_data = {
	"lowest_time": [],
	"generation": 0,
	"archievements": {
		"generation0": {
			"village_savior": true,
			"full_belly": false,
			"triple_kill": false
		},
		"generation1": {
			"ant_on_a_stick": false,
			"accidental_punch": false,
			"friendly_fire": false
		},
		"generation2": {
			"gotcha": false,
			"not_so_wet": false,
			"secret_weapon": false
		}
	}
}

const DEFAULT_VOLUME: float = 1.6

var game_settings: Dictionary = {
	"audio": {
		"Master": DEFAULT_VOLUME,
		"music": 1.3, # makes music slightly quieter by default
		"entity_sounds": DEFAULT_VOLUME,
		"player_sounds": DEFAULT_VOLUME,
		"environment_sounds": DEFAULT_VOLUME
	},
	"video": {
		"camera_shake": true
	},
	"locale": {
		"value": "DEFAULT"	
	}
}

var current_platform: String = "desktop" setget set_current_platform, get_current_platform # TEMP
var current_level: String = "" setget set_current_level, get_current_level
var current_level_time: Array = [] setget set_current_level_time, get_current_level_time
var current_arena_wave: int = 1 setget set_current_wave, get_current_wave

var last_lowest_level_time: Array = [] setget set_last_lowest_level_time, get_last_lowest_level_time

func set_current_platform(platform_name: String): current_platform = platform_name
func get_current_platform() -> String: return current_platform

func set_current_level(level_name: String): current_level = level_name
func get_current_level() -> String: return current_level

func set_current_level_time(time: Array): current_level_time = time
func get_current_level_time() -> Array: return current_level_time

func set_current_wave(wave_number: int): current_arena_wave = wave_number
func get_current_wave() -> int: return current_arena_wave

func set_player_data(key, value): player_data[key] = value
func get_player_data(key): return player_data[key]

func set_game_setting(group, key, value): 
	game_settings[group][key] = value
	print("setting %s key to: %s" % [key, value])
func get_game_setting(group, key): return game_settings[group][key]

func set_last_lowest_level_time(value: Array): last_lowest_level_time = value
func get_last_lowest_level_time() -> Array: return last_lowest_level_time
