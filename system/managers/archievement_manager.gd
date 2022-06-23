extends Node


var archievements: Dictionary = game_data.get_player_data("archievements") 



func _ready():
	# warning-ignore:return_value_discarded
	player_events.connect("archievement_made", self, "_on_archievement_made")
	


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
			debug_log.dprint("key: %s" % archievement)
			debug_log.dprint("value: %s" % archievements[generation][archievement])
			debug_log.dprint("finish_count: %s" % finish_count)
	
	return finish_count == 3

	
	
func _on_archievement_made(archievement: String):
	var generation = get_archievement_generation(archievement) 
	var player_generation: int = game_data.get_player_data("generation")

	if generation != player_generation: return
	if generation == -1: return
	
	debug_log.dprint("archievement made! %s" % archievement)
	archievements["generation%s" % generation][archievement] = true
	game_data.set_player_data("archievements", archievements)
	
	if generation_complete(): 
		game_data.set_player_data("generation", player_generation + 1)
		debug_log.dprint("generation complete! new generation: %s" % game_data.get_player_data("generation"))
	
	json_data_manager.save_game()
