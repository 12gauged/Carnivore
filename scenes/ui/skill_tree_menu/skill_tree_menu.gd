extends Control

signal opened_menu
signal exited_menu


var player_in_skill_tree_area: bool = false


func _ready():
	self.visible = false
	gui_events.connect("player_in_skill_tree_area", self, "_player_entered_area")
	gui_events.connect("player_left_skill_tree_area", self, "_player_exited_area")
	
func _input(event):
	if not player_in_skill_tree_area: return
	if not event is InputEventKey: return
	if not event.is_action_pressed("action_accept"): return
	open_menu()
	
	
	
func close_menu():
	self.visible = false
	player_events.emit_signal("unfreeze_player")
	emit_signal("exited_menu")
func open_menu():
	self.visible = true
	player_events.emit_signal("freeze_player")
	emit_signal("opened_menu")
	
	

func _player_entered_area(): player_in_skill_tree_area = true
func _player_exited_area(): player_in_skill_tree_area = false
func _on_home_button_pressed(): close_menu()
