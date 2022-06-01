extends Label


func _ready(): self.text = game_data.get_player_data("lowest_time")
