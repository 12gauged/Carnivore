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
			"not_so_wet": false,
			"accidental_punch": false
		},
		"generation2": {
			"secret_weapon": false,
			"ant_on_a_stick": false,
			"friendly_fire": false
		}
	}
}

var current_level: String = "" setget set_current_level, get_current_level

func set_current_level(level_name: String): current_level = level_name
func get_current_level() -> String: return current_level

func set_player_data(key, value): 
	player_data[key] = value
func get_player_data(key): 
	return player_data[key]
