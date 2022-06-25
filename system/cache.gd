extends Node

var game_cache: Dictionary = {}

func exists_on_cache(key: String): return key in game_cache.keys()
func add_to_cache(key: String, value): game_cache[key] = value
func get_from_cache(key: String):
	if game_cache.keys().has(key): return game_cache[key]
	else: return null
