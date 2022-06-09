extends Node

var player_data = {
	"lowest_time": "00:00",
	"generation": 0,
	"archievements": {
		"generation0": {
			"village_savior": false,
			"just_in_time": false,
			"its_raining_frogs": false
		},
		"generation1": {
			"gotcha": false,
			"accidental_punch": false,
			"friendly_fire": false
		},
		"generation2": {
			"ant_on_a_stick": false,
			"not_so_wet": false,
			"secret_weapon": false,
		}
	}
}

var game_settings: Dictionary = {
	"audio": {
		"main": 1.0,
		"enemies": 1.0,
		"player": 1.0,
		"sfx": 1.0,
		"environment": 1.0,
		"ui": 1.0,
	},
	"video": {
		"camera_shake": true,
		"fullscreen": true,
		"language": "en"
	}
}

var current_platform: String = "desktop" setget set_current_platform, get_current_platform # TEMP
var current_level: String = "" setget set_current_level, get_current_level
var current_arena_wave: int = 1 setget set_current_wave, get_current_wave

func set_current_platform(platform_name: String): current_platform = platform_name
func get_current_platform() -> String: return current_platform

func set_current_level(level_name: String): current_level = level_name
func get_current_level() -> String: return current_level

func set_current_wave(wave_number: int): current_arena_wave = wave_number
func get_current_wave() -> int: return current_arena_wave

func set_player_data(key, value): player_data[key] = value
func get_player_data(key): return player_data[key]
