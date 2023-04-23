extends Control

const movement_tutorial_text = "tutorial.movement.desktop"
const pick_stone_tutorial_text = "tutorial.pick_stone"
const shooting_tutorial_text = "tutorial.throw_stone.desktop"
const eating_tutorial_text = "tutorial.eating"
const hunger_tutorial_text = "tutorial.hunger"
const special_tutorial_text = "tutorial.special_attack.desktop"

const MOVEMENT_TUTORIAL_DURATION := 4
const HUNGER_TUTORIAL_DURATION := 4
const DELAY_BETWEEN_TUTORIALS := 2

enum {
	MOVEMENT,
	PICK_STONE,
	SHOOTING,
	EATING,
	HUNGER,
	SPECIAL
}
var tutorial_stage := MOVEMENT

onready var TutorialLabel: Label = $HBoxContainer/VBoxContainer/TutorialTextBox/Label
onready var TutorialSpecialAttackTextBox: TextureRect = $HBoxContainer/VBoxContainer/SpecialAttackTextBox
onready var TutorialThrowStoneTextBox: TextureRect = $HBoxContainer/VBoxContainer/ShootStoneTextBox
onready var TutorialTextBox: TextureRect = $HBoxContainer/VBoxContainer/TutorialTextBox
onready var MultiuseTimer: Timer = $multiuse_timer
onready var TextCooldownTimer: Timer = $text_cooldown_timer


func _ready():
	
	if game_data.current_platform == "mobile": 
		queue_free()
		return
	if game_data.get_player_data("bounty") > game_data.DEFAULT_BOUNTY:
		end_tutorial()
		return
	
	var keybind_dict: Dictionary = game_data.game_settings.desktop_keybinds.duplicate()	
	var controls: Array = [
		OS.get_scancode_string(keybind_dict["controls_up"]),
		OS.get_scancode_string(keybind_dict["controls_left"]),
		OS.get_scancode_string(keybind_dict["controls_down"]),
		OS.get_scancode_string(keybind_dict["controls_right"])
	]
	TutorialLabel.text = tr(movement_tutorial_text) % controls
	
	
	# warning-ignore:return_value_discarded
	player_events.connect("player_moving", self, "_on_player_movement_direction_updated")
	
	

func skip_tutorial_stage(text_to_show, new_stage, cooldown := 1.0):
	TutorialTextBox.visible = false
	TutorialLabel.text = tr(text_to_show)
	tutorial_stage = new_stage
	TextCooldownTimer.start(cooldown)

func end_tutorial():
	self.visible = false
	game_events.emit_signal("tutorial_finished")	
	
	if game_data.get_player_data("special_attack_tutorial_finished"): return
	TutorialTextBox.visible = false
	self.visible = true
	# warning-ignore:return_value_discarded
	player_events.connect("special_attack_tutorial_available", self, "_on_player_special_attack_available")
	
	

func _on_player_movement_direction_updated():
	if not MultiuseTimer.is_stopped(): return
	MultiuseTimer.start(MOVEMENT_TUTORIAL_DURATION)
	
	
func _on_player_collected_projectile(_projectile):
	TutorialTextBox.visible = false
	tutorial_stage = SHOOTING
	TextCooldownTimer.start(1.0)
	player_events.disconnect("projectile_collected", self, "_on_player_collected_projectile")
	
	
func _on_tutorial_ant_dead():
	TutorialThrowStoneTextBox.visible = false
	skip_tutorial_stage(eating_tutorial_text, EATING, 0.1)
	# warning-ignore:return_value_discarded
	player_events.connect("meat_consumed", self, "_on_meat_consumed")
	
	
func _on_meat_consumed():
	skip_tutorial_stage(hunger_tutorial_text, HUNGER)
	MultiuseTimer.start(HUNGER_TUTORIAL_DURATION)
	player_events.disconnect("meat_consumed", self, "_on_meat_consumed")
	
	
func _on_player_special_attack_available():
	if tutorial_stage == SPECIAL: return
	tutorial_stage = SPECIAL
	_on_text_cooldown_timer_timeout()	
	
	
func _on_player_entered_eat_state():
	game_data.set_player_data("special_attack_tutorial_finished", true)
	player_events.disconnect("special_attack_available", self, "_on_player_special_attack_available")
	player_events.disconnect("entered_eat_state", self, "_on_player_entered_eat_state")
	end_tutorial()
	
func _on_multiuse_timer_timeout():
	match tutorial_stage:
		MOVEMENT: 
			skip_tutorial_stage(pick_stone_tutorial_text, PICK_STONE)
			player_events.disconnect("player_moving", self, "_on_player_movement_direction_updated")
		HUNGER: 
			end_tutorial()
	
func _on_text_cooldown_timer_timeout():
	TutorialTextBox.visible = true if not tutorial_stage in [SHOOTING, SPECIAL] else false
	
	match tutorial_stage:
		PICK_STONE:
			# warning-ignore:return_value_discarded
			player_events.connect("projectile_collected", self, "_on_player_collected_projectile")
			game_events.emit_signal("spawn_tutorial_stone")
		SHOOTING:
			TutorialThrowStoneTextBox.visible = true
			game_events.emit_signal("spawn_tutorial_ant")
			# warning-ignore:return_value_discarded
			game_events.connect("tutorial_ant_dead", self, "_on_tutorial_ant_dead")
		SPECIAL:
			TutorialSpecialAttackTextBox.visible = true
			# warning-ignore:return_value_discarded
			player_events.connect("entered_eat_state", self, "_on_player_entered_eat_state")
