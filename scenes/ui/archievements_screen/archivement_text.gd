extends TextureRect

export(int) var id = 0

onready var description: Label = $description
var archievements: Dictionary = game_data.get_player_data("archievements")

func _ready():
	description.text = description.text
