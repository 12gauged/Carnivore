extends Node

export(String, "desktop", "mobile") var platform = "mobile"

func _ready():
	self.visible = game_data.get_current_platform() == platform
