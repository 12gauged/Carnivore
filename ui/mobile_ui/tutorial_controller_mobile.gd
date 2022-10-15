extends Control


signal request_movement_joystick_animation
signal request_stop_movement_joystick_animation

onready var MultiuseTimer := $timer
onready var TutorialTextCooldown := $tutorial_text_show_cooldown
onready var TutorialTextBox := $HBoxContainer/VBoxContainer/TutorialTextBox
onready var TutorialLabel := $HBoxContainer/VBoxContainer/TutorialTextBox/Label


const movement_tutorial_text = "tutorial.movement"
const pick_stone_tutorial_text = "tutorial.pick_stone"
const shooting_tutorial_text = "tutorial.throw_stone"
const hunger_tutorial_text = "tutorial.hunger"
const special_tutorial_text = "tutorial.special_attack"


enum {
	MOVEMENT,
	PICK_STONE,
	SHOOTING,
	SPECIAL
}
var tutorial_stage := MOVEMENT


func _ready():
	emit_signal("request_movement_joystick_animation")


func _on_movement_joystick_used():
	emit_signal("request_stop_movement_joystick_animation")
	if !MultiuseTimer.is_stopped(): return
	MultiuseTimer.start(2)


func _on_timer_timeout():
	match tutorial_stage:
		MOVEMENT: 
			TutorialTextBox.visible = false
			TutorialLabel.text = tr(pick_stone_tutorial_text)
			tutorial_stage = PICK_STONE
			TutorialTextCooldown.start()



func _on_tutorial_text_show_cooldown_timeout():
	TutorialTextBox.visible = true
	
	match tutorial_stage:
		PICK_STONE:
			game_events.emit_signal("spawn_tutorial_stone")
