extends TextureRect


export(Array, String, "stone_projectile", "fireball_projectile", "spear_projectile_player") var projectiles_to_track



func _ready():
	player_events.connect("projectile_collected", self, "on_projectile_collected")
	self.visible = false
	
	
func on_projectile_collected(projectile: String):
	if projectile in projectiles_to_track:
		self.visible = true
