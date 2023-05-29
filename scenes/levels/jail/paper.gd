extends Highlight


func _ready():
	if game_data.get_player_data("bounty") > 500: return # if you haven't entered the arena yet
	queue_free()
	
