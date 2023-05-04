extends Control


signal opened_menu
signal exited_menu


const DEFAULT_BOUNTY_LABEL_TEXT = "ui.progress_menu.bounty"


onready var BountyLabel = $VBoxContainer/BountyLabel



var player_near_table: bool = false



func _ready():
	gui_events.connect("player_near_table", self, "on_player_near_table")
	gui_events.connect("player_far_from_table", self, "on_player_far_from_table")
	player_events.connect("player_interacted", self, "_on_player_interacted")
	close_menu()
	
	

func on_player_near_table(): player_near_table = true
func on_player_far_from_table(): player_near_table = false
	
	
	
func open_menu():
	if self.visible: return
	self.visible = true
	BountyLabel.text = tr(DEFAULT_BOUNTY_LABEL_TEXT) % str(game_data.get_player_data("bounty"))
	game_data.can_pause= false
	player_events.emit_signal("freeze_player")
	emit_signal("opened_menu")
func close_menu():
	self.visible = false
	game_data.can_pause = true
	player_events.emit_signal("unfreeze_player")
	emit_signal("exited_menu")


func _on_player_interacted():
	if not player_near_table: return
	open_menu()
func _on_exit_button_button_pressed(_id):
	close_menu()
