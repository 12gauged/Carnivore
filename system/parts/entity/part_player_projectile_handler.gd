extends Component

signal projectile_collected
signal projectile_thrown 
signal add_tag_request(tag)
signal remove_tag_request(tag)

onready var ShotDelayTimer: Timer = $shot_delay_timer
onready var ProjectileTexture: Sprite = $projectile_holder/projectile_texture
onready var ProjectileHolder: Node2D = $projectile_holder
onready var ProjectileSpawner = $projectile_spawner

onready var ThrowSoundEffect = $throw_sound_effect

onready var ProjectileGroup = toolbox.get_node_in_group("projectiles")

var target_direction: Vector2
var last_shooting_direction: Vector2
var projectile_type: String = ""

var on_eat_state: bool = false

var ProjectileScene
var ProjectileInstance

const projectile_speeds: Dictionary = {
	"stone_projectile": 450
}
		
func _ready():
	# warning-ignore:return_value_discarded
	input_events.connect("player_shooting_joystick_released", self, "_on_player_shooting_joystick_released")
	# warning-ignore:return_value_discarded
	input_events.connect("player_shooting_direction_updated", self, "_on_player_shooting_direction_updated")
	# warning-ignore:return_value_discarded
	player_events.connect("entered_eat_state", self, "_on_player_entered_eat_state")
	# warning-ignore:return_value_discarded
	player_events.connect("exited_eat_state", self, "_on_player_exited_eat_state")
	# warning-ignore:return_value_discarded
	player_events.connect("projectile_collected", self, "_on_projectile_collected")
	
	
func _input(event):
	if event is InputEventMouseMotion: set_target_direction(global_position.direction_to(get_global_mouse_position()))
	
func shoot_projectile():
	if projectile_type.empty(): return
	if !ShotDelayTimer.is_stopped(): return
	
	ThrowSoundEffect.play()
	ShotDelayTimer.start()
	camera_events.emit_signal("camera_shake_request", 0.2, 0.5)
	player_events.emit_signal("projectile_thrown")
	emit_signal("projectile_thrown")
	emit_signal("remove_tag_request", "HOLDING_PROJECTILE")
	spawn_projectile()
	set_projectile("")
	
func set_target_direction(value: Vector2): target_direction = value
func get_target_direction() -> Vector2: return target_direction
	
func set_projectile(type: String):
	if on_eat_state: return
	
	projectile_type = type
	
	var texture = resources.get_resource("sprites", projectile_type) if !projectile_type.empty() else null
	ProjectileTexture.texture = texture
	
	if projectile_type != "": 
		emit_signal("projectile_collected")
		emit_signal("add_tag_request", "HOLDING_PROJECTILE")

func spawn_projectile():
	ProjectileSpawner.entity_name = projectile_type
	var InstancedProjectile = ProjectileSpawner.spawn_entity()
	
	InstancedProjectile.set_direction(get_target_direction())
	InstancedProjectile.set_speed(projectile_speeds[projectile_type])
	


func _on_projectile_collected(projectile): set_projectile(projectile)
	
func _on_projectile_spawner_entity_spawned(ProjectileNode):
	ProjectileNode.set_hitbox_tags(["PLAYER_PROJECTILE"])

func _on_player_entered_eat_state():
	self.visible = false
	on_eat_state = true
func _on_player_exited_eat_state():
	self.visible = true
	on_eat_state = false

func _on_player_shooting_direction_updated(value):
	if value == Vector2.ZERO and last_shooting_direction != Vector2.ZERO:
		target_direction = last_shooting_direction
	if value != last_shooting_direction:
		last_shooting_direction = value

func _on_player_shooting_joystick_released():
	shoot_projectile()
