extends Node2D
class_name Projectile

signal collided_no_args()
signal collided(hurtbox, projectile)
signal deleted(projectile)

export(int) var speed = 10
export(Array) var TAGS = []
export(int) var max_lifetime = 60
export(bool) var face_direction = false

onready var hitbox = $part_hitbox
onready var LifetimeTimer = $lifetime_timer
onready var scene_tree = get_tree()
var direction: Vector2 = Vector2.ZERO setget set_direction

func _ready(): 
	if !is_instance_valid(LifetimeTimer): return
	LifetimeTimer.start(max_lifetime)

func _physics_process(delta):
	global_position += direction * (speed * delta)
	if face_direction: look_at(self.global_position + direction)
	
func set_direction(value: Vector2): direction = value.normalized()
func set_speed(value: int): speed = value

func set_hitbox_tags(tags: Array): 
	if !is_instance_valid(hitbox): return
	hitbox.TAGS = tags



func _on_lifetime_timer_timeout(): 
	emit_signal("deleted", self)
	queue_free()

func _on_part_hitbox_hit_detected(Hurtbox): 
	emit_signal("collided", Hurtbox, self)
	emit_signal("collided_no_args")
