extends Entity

const HUNGER_DECREASE_DELAY = 3.0
const ENERGY_DECREASE_DELAY = 0.8

const HUNGER_DAMAGE = 1
const DAMAGE_CAMERA_SHAKE_DURATION = 0.3
const DAMAGE_CAMERA_SHAKE_INTENSITY = 0.8

export(int) var MAX_HUNGER = 6
export(int) var MAX_ENERGY = 6

onready var HungerDecreaseTimer: Timer = $hunger_decrease_delay
onready var SpriteMaterial: ShaderMaterial = $texture.material
onready var InvincibilityTimer: Timer = $invincibility_timer

func _ready():
	add_tag("PLAYER")
	
	# creating new stats
	stats["hunger"] = MAX_HUNGER / 2
	stats["can_get_hungry"] = false
	stats["energy"] = 0
	call_deferred("update_stat", "hunger", get_stat("hunger"), false)
	
	# warning-ignore:return_value_discarded
	input_events.connect("player_movement_direction_updated", self, "_on_player_movement_direction_updated")
	# warning-ignore:return_value_discarded
	player_events.connect("meat_consumed", self, "consume_meat")
	# warning-ignore:return_value_discarded
	player_events.connect("enter_eat_state_request", self, "enter_eat_state")
	# warning-ignore:return_value_discarded
	player_events.connect("set_stat_value", self, "update_stat")
	# warning-ignore:return_value_discarded
	player_events.connect("force_exit_from_eat_state", self, "_on_exit_from_eat_state_forced")
		
func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("debug_f3"): die()
		if event.is_action_pressed("debug_f4"): update_stat("energy", int(min(get_stat("energy") + 1, MAX_ENERGY)))
		if event.is_action_pressed("debug_f6"): update_stat("health", int(max(get_stat("health") - 1, 0)))
	
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		if event.is_pressed(): enter_eat_state()

func _process(_delta):
	if get_state() in CONSTANT_STATES: process_constant_state()
	else: process_inconstant_state()
	TextureRes.flip_v = rotation_degrees > 90 and rotation_degrees < -90
	
func process_constant_state(): pass

func process_inconstant_state():
	if get_state() != "EAT":
		set_state("IDLE" if movement_direction == Vector2.ZERO else "MOVE")

func update_stat(id: String, value: int, animate: bool = true):
	set_stat(id, value)
	player_events.emit_signal("status_value_update", id, get_stat(id), animate)
	
	if id != "can_get_hungry": return
	
	if !get_stat("can_get_hungry") and !HungerDecreaseTimer.is_stopped():
		HungerDecreaseTimer.stop()
	else:
		HungerDecreaseTimer.start()

func start_invincibility():
	set_stat("invincible", true)
	InvincibilityTimer.start()

func stop_invincibility():
	set_stat("invincible", false)

func enter_eat_state():
	if get_state() == "EAT" or get_stat("energy") < 5: return
	add_tag("EAT")
	set_state("EAT")
	InvincibilityTimer.stop()
	set_stat("invincible", true)
	player_events.emit_signal("entered_eat_state")
	# yeah i use the same timer for both hunger and energy, deal with it
	reset_stat_decrease_timer("energy")
	set_movement_direction(Vector2.LEFT)
	input_events.emit_signal("player_movement_direction_updated", Vector2.LEFT)
	
	## Archievement
	if get_stat("health") <= 2:
		player_events.emit_signal("archievement_made", "just_in_time", true)
	
func exit_eat_state():
	start_invincibility()
	remove_tag("EAT")
	set_state("IDLE")
	set_stat("invincible", false)
	reset_stat_decrease_timer("hunger")
	player_events.emit_signal("exited_eat_state")
	set_rotation_degrees(0.0)
	set_movement_direction(Vector2.ZERO)

func consume_meat():
	if get_state() == "EAT": return
	
	HungerDecreaseTimer.stop()
	if get_stat("hunger") < MAX_HUNGER:
		update_stat("hunger", get_stat("hunger") + 1)
	else:
		update_stat("energy", int(min(get_stat("energy") + 1, MAX_ENERGY)))
	HungerDecreaseTimer.start()
	
func consume_enemy(EnemyNode):
	var shake_intensity: float = 0.3 if "PLAYER" in EnemyNode.TAGS else 1.5
	camera_events.emit_signal("camera_shake_request", 0.15, shake_intensity)
	
	if not "PLAYER" in EnemyNode.TAGS:
		# when in eating mode, the player regenerates health
		# instead of energy when the hunger is full
		if get_stat("hunger") < MAX_HUNGER:
			update_stat("hunger", get_stat("hunger") + 1)
		elif get_stat("health") < MAX_HEALTH:
			update_stat("health", get_stat("health") + 1)
		
func reset_stat_decrease_timer(mode: String):
	HungerDecreaseTimer.stop()
	match mode:
		"hunger": HungerDecreaseTimer.wait_time = HUNGER_DECREASE_DELAY
		"energy": HungerDecreaseTimer.wait_time = ENERGY_DECREASE_DELAY
	HungerDecreaseTimer.start()
	
func apply_damage(damage: int):
	if damage <= 0: return
	update_stat("health", get_stat("health") - damage)
	start_invincibility()
	start_blinking()
	camera_events.emit_signal("camera_shake_request", DAMAGE_CAMERA_SHAKE_DURATION, DAMAGE_CAMERA_SHAKE_INTENSITY)
		
		

func _on_hunger_decrease_delay_timeout():
	match get_state():
		"EAT":
			if get_stat("energy") <= 0: 
				exit_eat_state()
				return
			update_stat("energy", int(max(get_stat("energy") - 1, 0)))
		_:
			if get_stat("hunger") <= 0: 
				apply_damage(1)
				return
			update_stat("hunger", int(max(get_stat("hunger") - 1, 0)))
			
func _on_exit_from_eat_state_forced(): exit_eat_state()
func _on_player_movement_direction_updated(value): 
	if get_state() == "EAT" and value == Vector2.ZERO: return
	set_movement_direction(value)
