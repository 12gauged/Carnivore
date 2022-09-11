extends HBoxContainer

signal request_key_assignment(action, requester, type)

export(String) var assigned_action = ""
onready var AnimPlayer := $AnimationPlayer
onready var KeyLabel := $button_medium/Label
onready var assigned_keycode = game_data.game_settings.desktop_keybinds[assigned_action]

func _ready():
	if assigned_keycode == null: return
	set_text(OS.get_scancode_string(assigned_keycode))


func _on_button_medium_button_pressed(_id):
	emit_signal("request_key_assignment", assigned_action, self, "key")
	

func start_flashing(): 
	set_text("_")
	AnimPlayer.play("key_label_flash")
func stop_flashing(): AnimPlayer.play("RESET")

func set_text(text: String): 
	if text.length() > 3: text = text.substr(0, 3)
	KeyLabel.text = text
