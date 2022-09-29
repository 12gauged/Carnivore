extends KinematicBody2D
class_name Entity



signal state_changed(new_state, old_state)
signal dead(id)
signal hurt()
signal deleted()
signal frozen()
signal unfrozen()
signal self_give(node)

export(int) var MAX_HEALTH = 1
export(int) var MAX_SPEED = 70
export(int) var ACCELERATION = 700
export(int) var FRICTION = 600
export(PackedScene) var DeathParticle

onready var stats = {"health": MAX_HEALTH, "invincible": false}
onready var Collision: CollisionShape2D = $collision
onready var TextureRes = $texture
onready var ParticleGroup = toolbox.get_node_in_group("particles")

export(String) var ID = ""
export(Array) var TAGS = ["COMP_EXECUTER", "ENTITY"]
export(String) var DEFAULT_STATE = ""
export(String) var STARTING_STATE = ""
export(Array) var CONSTANT_STATES = []
export(Array) var state_execution_pattern

var damage_blink_delay = [0, 20]
var blinking
var movement_direction: Vector2 = Vector2.ZERO setget set_movement_direction
var velocity: Vector2 = Vector2.ZERO
var state: String = "" setget set_state, get_state
var state_id: int = 0
var frozen: bool = false

var DEFAULT_FRICTION
var DEFAULT_ACCELERATION
var DEFAULT_MAX_SPEED



func _ready():
	DEFAULT_FRICTION = FRICTION
	DEFAULT_ACCELERATION = ACCELERATION
	DEFAULT_MAX_SPEED = MAX_SPEED
	
	emit_signal("self_give", self)
	STARTING_STATE = DEFAULT_STATE if STARTING_STATE.empty() else STARTING_STATE
	set_state(STARTING_STATE)
	

func _physics_process(delta):
	if blinking: count_damage_blink_delay()
	else: stop_blinking()
	
	# moves the entity
	if state in CONSTANT_STATES: return
	match movement_direction:
		Vector2.ZERO: stop_moving(delta)
		_: move(movement_direction, delta)
	velocity = move_and_slide(velocity)
		


func count_damage_blink_delay():
	var damage_blink_delay_ended = damage_blink_delay[0] == damage_blink_delay[1]
	damage_blink_delay[0] = 0 if damage_blink_delay_ended else damage_blink_delay[0] + 1
	blinking = !damage_blink_delay_ended
		
func stop_blinking():
	var texture = get_texture()
	if texture != null and texture.material != null:
		texture.material.set_shader_param("active", false)

func start_blinking():
	var texture = get_texture()
	if texture != null and texture.material != null:
		texture.material.set_shader_param("active", true)
	blinking = true
	

func emit_particle(Particle):
	var NewParticle = Particle.instance()
	ParticleGroup.add_child(NewParticle)
	NewParticle.global_position = self.global_position

func move(direction, delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
func stop_moving(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
func set_movement_direction(value: Vector2):
	movement_direction = value
	
func set_rotation_degrees(value: float): rotation_degrees = value
	
func start_invincibility(): set_stat("invincible", true)
func stop_invincibility(): set_stat("invincible", false)
	
func die(): 
	emit_signal("dead", ID)
	emit_signal("deleted")
	emit_particle(DeathParticle)
	queue_free()
	
func go_to_next_state():
	state_id = state_id + 1 if state_id < len(state_execution_pattern) - 1 else 0
	set_state(state_execution_pattern[state_id])
	
func start_state_pattern():
	set_state(state_execution_pattern[0])

func set_stat(stat: String, value): stats[stat] = value
func get_stat(stat: String): return stats[stat]

func add_tag(new_tag: String):
	if new_tag in TAGS: return
	TAGS = TAGS + [new_tag]
func remove_tag(tag: String):
	if !tag in TAGS: return
	TAGS.remove(TAGS.find(tag))

func get_state() -> String:	return state
func set_state(value: String):
	emit_signal("state_changed", value, state)
	state = value
	
func get_texture() -> Node:
	if is_instance_valid(TextureRes): return TextureRes
	return null

func apply_damage(damage: int):
	if damage <= 0: return
	if damage >= get_stat("health"):
		die()
		return
	emit_signal("hurt")
	set_stat("health", get_stat("health") - damage)
	start_blinking()

func _on_invincibility_timer_timeout(): stop_invincibility()
func disable_collision(): Collision.set_deferred("disabled", true)
func enable_collision(): Collision.set_deferred("disabled", false)
	
func _on_damage_received(Hitbox: DetectionBox):
	if get_stat("invincible") == true and !Hitbox.override_invincibility: return
	apply_damage(Hitbox.damage)
	if Hitbox.delete_on_hit: 
		Hitbox.get_parent().queue_free()
	
func freeze():
	set_process(false)
	set_process_input(false)
	frozen = true
	movement_direction = Vector2.ZERO
	emit_signal("frozen")
	
func unfreeze():
	set_process(true)
	set_process_input(true)
	frozen = false
	emit_signal("unfrozen")
	
