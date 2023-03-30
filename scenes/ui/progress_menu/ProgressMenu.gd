extends Control


signal opened_menu
signal exited_menu



var player_near_table: bool = false



func _ready():
	gui_events.connect("player_near_table", self, "on_player_near_table")
	gui_events.connect("player_far_from_table", self, "on_player_far_from_table")
	
	close_menu()



func _input(event):
	if not player_near_table: return
	if not event is InputEventKey: return
	if not event.is_action_pressed("controls_interact"): return
	open_menu()
	
	

func on_player_near_table(): player_near_table = true
func on_player_far_from_table(): player_near_table = false
	
	
	
func open_menu():
	self.visible = true
	emit_signal("opened_menu")
func close_menu():
	self.visible = false
	emit_signal("exited_menu")


func _on_exit_button_button_pressed(_id):
	close_menu()
