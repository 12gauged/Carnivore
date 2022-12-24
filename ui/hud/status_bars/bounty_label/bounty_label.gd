extends Label


onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
var player_bounty: int


func _ready():
	set_player_bounty(game_data.get_player_data("bounty"))
	player_events.connect("bounty_increased", self, "_on_bounty_increased")
	
	
func set_player_bounty(value):
	player_bounty = value
	self.text = str(player_bounty)	


func _on_bounty_increased(value: int):
	set_player_bounty(player_bounty + value)
	AnimPlayer.play("highlight")
	
