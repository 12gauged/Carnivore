extends GridContainer

signal go_to_main_menu
signal go_to_jail

var player_in_tutorial: bool = true

func _ready():
	yield(get_tree().create_timer(0.1), "timeout") # makes sure that the initial player bounty is set
	player_in_tutorial = game_data.initial_player_bounty == game_data.DEFAULT_BOUNTY


func _on_main_menu_button_pressed():
	if player_in_tutorial:
		emit_signal("go_to_main_menu")
		return
	emit_signal("go_to_jail")
