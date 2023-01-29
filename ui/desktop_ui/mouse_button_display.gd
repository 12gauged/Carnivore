extends TextureRect

export(String, "controls_shoot", "controls_special") var assigned_action = "controls_shoot"

func _ready():
	var mouse_textures: Dictionary = resources.get_resource("sprites", "mouse_textures")
	self.texture = mouse_textures[game_data.get_game_setting("desktop_keybinds", assigned_action)]
