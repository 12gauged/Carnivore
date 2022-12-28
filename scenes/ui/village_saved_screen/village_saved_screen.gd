extends Control

onready var BountyLabel: Label = $bounty_container/bounty

func _ready():
	BountyLabel.text = str("+%s" % game_data.level_player_bounty)
	game_data.set_player_data("bounty", game_data.initial_player_bounty + game_data.level_player_bounty)
	global_data_manager.save_player_data()
