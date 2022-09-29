extends Node


var archievements: Dictionary = game_data.get_player_data("archievements") 
var starting_player_generation: int = 0



func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("archievement_made", self, "_on_archievement_made")
	# warning-ignore:return_value_discarded
	game_events.connect("level_started", self, "_on_level_started")


	
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

	
	
func _on_archievement_made(archievement: String, notify):
	var archievement_generation = game_functions.get_archievement_generation(archievement) 
	var player_generation: int = game_data.get_player_data("generation")

	if game_data.get_player_data("generation") < 0: return
	if archievement_generation != starting_player_generation: return
	if !game_functions.validate_archievement(archievement, starting_player_generation): return
	
	debug_log.dprint("archievement made! %s" % archievement)
	archievements["generation%s" % archievement_generation][archievement] = true
	log_archievement_on_cache(archievement)
	gui_events.emit_signal("notify_archievement", archievement, notify)
	
	game_data.set_player_data("archievements", archievements)
	
	if generation_complete(): 
		game_data.set_player_data("generation", player_generation + 1)
		debug_log.dprint("generation complete! new generation: %s" % game_data.get_player_data("generation"))
	
	global_data_manager.save_player_data()
	
	
func _on_level_started(): starting_player_generation = game_data.get_player_data("generation")
