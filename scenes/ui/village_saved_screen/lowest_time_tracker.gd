extends Label

func _ready(): 
	var lowest_time = game_data.get_player_data("lowest_time")
	self.text = toolbox.convert_time_to_text(lowest_time[0], lowest_time[1])
