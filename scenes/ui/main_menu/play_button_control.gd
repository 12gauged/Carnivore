extends Node

onready var GoToJail: Node2D = $go_to_jail
onready var GoToTutorialLevel: Node2D = $go_to_tutorial_level


func _on_play_button_pressed():
	if game_data.get_player_data("bounty") == game_data.DEFAULT_BOUNTY:
		GoToTutorialLevel.call_method()
		return
	GoToJail.call_method()
