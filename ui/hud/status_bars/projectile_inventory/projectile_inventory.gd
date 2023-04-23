extends HBoxContainer


const COLOR_UNOBTAINED = Color(0.25, 0.25, 0.25, 1.0)
const COLOR_OBTAINED = Color.white
const COLOR_HELD = Color.yellow



var held_projectile
var inventory: Dictionary = {
	"stone_projectile": false,
	"spear_projectile_player": false,
	"fireball_projectile": false
}



func _ready():
	player_events.connect("projectile_inventory_updated", self, "_on_projectile_inventory_updated")
	player_events.connect("held_projectile_updated", self, "_on_held_projectile_updated")
	
	for projectile in inventory:
		set_unobtained(projectile)
	
	
	
func _on_projectile_inventory_updated(inventory):
	for projectile in inventory:
		if inventory[projectile]: set_obtained(projectile)
		
func _on_held_projectile_updated(new_projectile):
	if new_projectile == "" and is_instance_valid(held_projectile):
		held_projectile.modulate = COLOR_UNOBTAINED
		held_projectile = null
		return
	set_held(new_projectile)
	
	
	
func set_unobtained(projectile): get_node(projectile).modulate = COLOR_UNOBTAINED
func set_obtained(projectile): 
	var node = get_node(projectile)
	if node.modulate == COLOR_HELD: return
	get_node(projectile).modulate = COLOR_OBTAINED
func set_held(projectile): 
	if is_instance_valid(held_projectile): held_projectile.modulate = COLOR_OBTAINED
	held_projectile = get_node(projectile)
	held_projectile.modulate = COLOR_HELD
