extends Control

onready var InteractButton = $interact_button
onready var SpecialAttackButton = $special_attack_button

func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("show_interact_button", self, "_show_interact_button")
	

func _show_interact_button():
	InteractButton.visible = true
	SpecialAttackButton.visible = false
