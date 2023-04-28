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
	json_data_manager.save_all()

func is_game_paused() -> bool: 
	var SceneTreeNode = get_tree()
	return SceneTreeNode.paused == true
	
	
func set_time_scale(value: float):
	Engine.set_time_scale(value)
