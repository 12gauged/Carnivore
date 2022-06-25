extends Node


var archievements: Dictionary = game_data.get_player_data("archievements") 
var starting_player_generation: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("archievement_made", self, "_on_archievement_made")
	# warning-ignore:return_value_discarded
	game_events.connect("level_started", self, "_on_level_started")
	


func get_archievement_generation(archievement) -> int:
	if archievement in archievements.generation0: return 0
	elif archievement in archievements.generation1: return 1
	elif archievement in archievements.generation2: return 2
	return -1
	
func generation_complete():
	var finish_count: int = 0
	
	for generation in archievements.keys():
		for archievement in archievements[generation]:
			finish_count += 1 if archievements[generation][archievement] else 0
	return finish_count == 3
	
func log_archievement_on_cache(archievement):
	if cache.exists_on_cache("archievement_log"):
		var updated_archievement_log: Array = cache.get_from_cache("archievement_log")
		updated_archievement_log.append(archievement)
		cache.add_to_cache("archievement_log", updated_archievement_log)
	else: 
		cache.add_to_cache("archievement_log", [archievement])

	
	
func _on_archievement_made(archievement: String):
	var generation = get_archievement_generation(archievement) 
	var player_generation: int = game_data.get_player_data("generation")
	var requested_archievement_stat = archievements["generation%s" % generation][archievement]

	print("r_archievement_stt: %s\narchievement: %s\n" % [requested_archievement_stat, archievement])

	if generation != starting_player_generation: return
	if requested_archievement_stat == true: return ## returns if the archievement is complete
	if generation == -1: return
	
	debug_log.dprint("archievement made! %s" % archievement)
	archievements["generation%s" % generation][archievement] = true # can't use the variable here for some reason..
	log_archievement_on_cache(archievement)
	
	game_data.set_player_data("archievements", archievements)
	
	if generation_complete(): 
		game_data.set_player_data("generation", player_generation + 1)
		debug_log.dprint("generation complete! new generation: %s" % game_data.get_player_data("generation"))
	
	json_data_manager.save_game()
	
	
func _on_level_started(): starting_player_generation = game_data.get_player_data("generation")
