extends HBoxContainer

signal request_key_assignment(id)

export(String) var assigned_action = ""
onready var KeyLabel := $button_medium/Label
onready var assigned_keycode: int = game_data.game_settings.desktop_keybinds[assigned_action]

func _ready():
	KeyLabel.text = OS.get_scancode_string(assigned_keycode)


func _on_button_medium_button_pressed(_id):
	emit_signal("request_key_assignment", assigned_action)
