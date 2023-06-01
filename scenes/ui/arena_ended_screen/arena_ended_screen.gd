extends Control


export(NodePath) var GoToJailMethodCallerPath


signal screen_visible

onready var GoToJailMethodCaller = get_node(GoToJailMethodCallerPath)
onready var animation_player = $AnimationPlayer


func _ready():
	gui_events.connect("show_arena_ended_screen", self, "_on_arena_ended")
	self.visible = false
	
	
	if game_data.get_player_data("bounty") > 500: 
		GoToJailMethodCaller.method.args[1] = "jail"
		return
	GoToJailMethodCaller.method.args[1] = "faction_interest_cutscene"




func _on_any_button_pressed():
	var new_bounty = game_data.initial_player_bounty + game_data.level_player_bounty
	game_data.set_player_data("bounty", new_bounty)
	game_data.set_player_data("skill_points", game_data.player_data.skill_points + 1)
	
	
	global_data_manager.save_player_data()
	game_data.level_player_bounty = 0
	game_functions.set_time_scale(1.0)
	
	
	
func _on_arena_ended():
	animation_player.play("fade_in")
	emit_signal("screen_visible")
	game_events.emit_signal("stop_music_fade_out")
	player_events.emit_signal("freeze_player")
	gui_events.emit_signal("hide_full_hud")
	
	if game_data.initial_player_bounty + game_data.level_player_bounty > game_data.TARGET_BOUNTY:
		GoToJailMethodCaller.method.args[1] = "ending_cutscene"
