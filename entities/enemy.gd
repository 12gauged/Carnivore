extends Entity
class_name Enemy

export(int) var bounty_value = 5

onready var Player = toolbox.get_node_in_group("player")
onready var AI_TARGET = Player

func _ready():
	# warning-ignore:return_value_discarded
	connect("deleted", self, "_on_deleted")
	
	if !has_node("bounty_indicator_emitter"): return
	$bounty_indicator_emitter.add_custom_value("bounty_value", self.bounty_value)
	
func _on_deleted():
	player_events.emit_signal("bounty_increased", bounty_value)
	camera_events.emit_signal("camera_shake_request", 0.2, 2)
	
func _on_damage_received(Hitbox: DetectionBox):
	if get_stat("invincible") == true and !Hitbox.override_invincibility: return
	
	var damage = Hitbox.damage
	apply_damage(damage)

	if Hitbox.delete_on_hit: Hitbox.get_parent().queue_free()
