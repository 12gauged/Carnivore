extends Entity
class_name Enemy

export(int) var bounty_value = 5

const FIRE_DURATION: float = 3.0
const FIRE_DAMAGE_DELAY: float = 0.6

onready var FireParticles: CPUParticles2D = $fire_particles
onready var FireParticlesDurationTimer: Timer = $fire_particles/duration_timer
onready var FireDamageDelay: Timer = $fire_particles/damage_delay

onready var BountyIndicatorEmitter = $bounty_indicator_emitter
onready var Player = toolbox.get_node_in_group("player")
onready var AI_TARGET = Player

var on_fire: bool = false

func _ready():
	# warning-ignore:return_value_discarded
	connect("deleted", self, "_on_deleted")
	if !has_node("bounty_indicator_emitter"): return
	BountyIndicatorEmitter.add_custom_value("bounty_value", bounty_value)
	
	
func _process(_delta):
	fire_damage()
	
	
func fire_damage():
	if !on_fire: return
	if !FireDamageDelay.is_stopped(): return
	FireDamageDelay.start(FIRE_DAMAGE_DELAY)
	apply_damage(2)
	
	
func _on_deleted():
	player_events.emit_signal("bounty_increased", bounty_value)
	game_data.level_player_bounty += bounty_value
	camera_events.emit_signal("camera_shake_request", 0.2, 2)
	
	
func set_on_fire():
	FireParticlesDurationTimer.start(FIRE_DURATION)
	FireParticles.emitting = true
	on_fire = true
	
func on_fire_particles_duration_timer_out():
	on_fire = false
	FireParticles.emitting = false
	
	
func _on_damage_received(Hitbox: DetectionBox):
	if get_stat("invincible") == true and !Hitbox.override_invincibility: return
	if Hitbox.damage_type == "fire": set_on_fire()
	
	var damage = Hitbox.damage
	apply_damage(damage)

	if Hitbox.delete_on_hit: Hitbox.get_parent().queue_free()
