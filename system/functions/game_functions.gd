extends Node


func toggle_pause():
	if !is_game_paused(): pause_game()
	else: resume_game()
	
func pause_game():
	var SceneTreeNode = get_tree()
	SceneTreeNode.paused = true
func resume_game():
	var SceneTreeNode = get_tree()
	SceneTreeNode.paused = false
	
func save_game():
	json_data_manager.save_game()

func is_game_paused() -> bool: 
	var SceneTreeNode = get_tree()
	return SceneTreeNode.paused == true
	
	
func get_archievement_generation(archievement) -> int:
	var archievements: Dictionary = game_data.get_player_data("archievements") 
	if archievement in archievements.generation0: return 0
	elif archievement in archievements.generation1: return 1
	elif archievement in archievements.generation2: return 2
	return -1
	
func validate_archievement(archievement, generation):
	print("validating archievement %s" % archievement)
	var archievements: Dictionary = game_data.get_player_data("archievements") 
	var requested_archievement_stat = archievements["generation%s" % generation][archievement]
	if requested_archievement_stat == true: return false ## if archievement has been completed
	if generation == -1: return false ## if the generation is invalid
	return true
