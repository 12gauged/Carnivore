extends Node

var cache: Dictionary = {}
var cache_key: int = -1

func _add_to_cache() -> int:
	var generated_key: int = cache_key + 1
	return generated_key
