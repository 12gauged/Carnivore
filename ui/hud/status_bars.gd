extends HBoxContainer


export(NodePath) var ShieldBarPath
onready var shield_bar = get_node(ShieldBarPath)
export(NodePath) var HealthBarPath
onready var health_bar = get_node(HealthBarPath)



func _ready():
	player_events.connect("status_value_update", self, "on_player_status_value_updated")
	
	var has_hard_skin = game_data.get_player_data("skills").hard_skin
	var has_body_armor = game_data.get_player_data("skills").body_armor
	
	
	show_shield_bar()
	if not (has_hard_skin or has_body_armor):
		show_health_bar()
		
		
		
		
func show_health_bar():
	health_bar.visible = true
	shield_bar.visible = false
func show_shield_bar():
	health_bar.visible = false
	shield_bar.visible = true
	
	
func on_player_status_value_updated(stat_id, value, _animate):
	if stat_id != "shields": return
	if health_bar.visible: return
	
	if value == 0: 
		show_health_bar()
	
