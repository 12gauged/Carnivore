extends Node


var archievements: Dictionary = game_data.get_player_data("archievements") 



func _ready():
	player_events.connect("archievement_made", self, "_on_archievement_made")
	


func get_archievement_generation(archievement) -> int:
	if archievement in archievements.generation0: return 0
	elif archievement in archievements.generation1: return 1
	elif archievement in archievements.generation2: return 2
	return -1
	
	
func _on_archievement_made(archievement: String):
	var generation = get_archievement_generation(archievement) 
	
	if generation != game_data.get_player_data("generation"): return
	if generation == -1: return
	
	debug_log.dprint("archievement made! %s" % archievement)
	archievements["generation%s" % generation][archievement] = true
	json_data_manager.save_game()
