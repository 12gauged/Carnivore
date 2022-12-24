extends Label


onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
var player_bounty: int
var post_tutorial_bounty: int


func _ready():
	set_player_bounty(game_data.get_player_data("bounty"))
	player_events.connect("bounty_increased", self, "_on_bounty_increased")
	
	post_tutorial_bounty = game_data.DEFAULT_BOUNTY + 10
	
	if player_bounty > post_tutorial_bounty:
		AnimPlayer.play("highlight_long")
		return
	self.modulate.a = 0
	
	
func set_player_bounty(value):
	player_bounty = value
	game_data.level_player_bounty = player_bounty
	self.text = str(player_bounty)	


func _on_bounty_increased(value: int):
	set_player_bounty(player_bounty + value)
	if player_bounty < post_tutorial_bounty: return
	AnimPlayer.play("highlight")
	
