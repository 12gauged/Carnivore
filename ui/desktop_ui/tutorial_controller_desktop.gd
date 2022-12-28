extends Control

const movement_tutorial_text = "tutorial.movement"
const pick_stone_tutorial_text = "tutorial.pick_stone"
const shooting_tutorial_text = "tutorial.throw_stone"
const eating_tutorial_text = "tutorial.eating"
const hunger_tutorial_text = "tutorial.hunger"
const special_tutorial_text = "tutorial.special_attack"

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


func _ready():
	if game_data.current_platform != "desktop": return
	
	end_tutorial()
	if game_data.get_player_data("bounty") > game_data.DEFAULT_BOUNTY:
		end_tutorial()
		return
	TutorialLabel.text = tr(movement_tutorial_text)
	
		
func end_tutorial():
	self.visible = false
	game_events.emit_signal("tutorial_finished")
