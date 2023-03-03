extends Node2D

onready var MobileInteractHint = $mobile_interact_hint
onready var DesktopInteractHint = $desktop_interact_hint
onready var KeyLabel = $desktop_interact_hint/interact_hint/key_label



func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("controls_updated", self, "_on_controls_updated")
	MobileInteractHint.visible = game_data.current_platform == "mobile"
	DesktopInteractHint.visible = game_data.current_platform == "desktop"
	set_key_label()
	
	
	
func set_key_label(): 
	var assigned_key_scancode = game_data.game_settings.desktop_keybinds.controls_interact
	KeyLabel.text = "NONE" if assigned_key_scancode == null else OS.get_scancode_string(assigned_key_scancode)
	
func show(): self.visible = true
func hide(): self.visible = false

func _on_controls_updated(): set_key_label()
