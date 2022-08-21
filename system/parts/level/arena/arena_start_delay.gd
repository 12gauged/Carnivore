extends Timer


func _ready():
	if game_data.get_player_data("generation") >= 0:
		self.start()
		return
