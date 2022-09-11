extends Node

onready var MovementTutorial = toolbox.get_node_in_group("tutorial_movement")
onready var PickStoneTutorial = toolbox.get_node_in_group("tutorial_pick_stone")
onready var ShootingTutorial = toolbox.get_node_in_group("tutorial_shooting")
onready var HungerTutorial = toolbox.get_node_in_group("tutorial_hunger")
onready var EatingTutorial = toolbox.get_node_in_group("tutorial_eating")

onready var MovementFirstAppearTimer: Timer = $movement_first_appear_timer
onready var MovementTimer: Timer = $movement_timer
onready var HungerTimer: Timer = $hunger_timer


enum TUTORIAL_STAGES {
	MOVEMENT,
	PICK_STONE,
	HUNGER,
	SHOOTING,
	EATING
}


var tutorial_stage: int = TUTORIAL_STAGES.MOVEMENT
var remaining_movement_time: float = 0.0


func _ready():
	if game_data.current_platform != "mobile": 
		game_events.emit_signal("tutorial_finished")
		game_events.emit_signal("spawn_tutorial_stone")
		return
	
	if game_data.get_player_data("generation") >= 0:
		game_events.emit_signal("tutorial_finished")
		for Tutorial in get_tree().get_nodes_in_group("tutorial"):
			Tutorial.visible = false
		return
		
	player_events.connect("player_moving", self, "_on_player_moving")
	player_events.connect("player_not_moving", self, "_on_player_not_moving")
	MovementFirstAppearTimer.start()
	remaining_movement_time = MovementTimer.time_left
	
	
## Movement Tutorial	

func _on_player_moving(): 
	if MovementTimer.is_stopped(): MovementTimer.start(remaining_movement_time)
func _on_player_not_moving(): 
	remaining_movement_time = MovementTimer.time_left
	MovementTimer.stop()
func _on_movement_timer_timeout():
	if tutorial_stage != TUTORIAL_STAGES.MOVEMENT: return
	player_events.connect("projectile_collected", self, "_on_player_projectile_collected")
	tutorial_stage = TUTORIAL_STAGES.PICK_STONE
	PickStoneTutorial.visible = true
	game_events.emit_signal("spawn_tutorial_stone")
	MovementTutorial.hide()
	
	
## Picking stone tutorial

func _on_player_projectile_collected(_projectile):
	if tutorial_stage != TUTORIAL_STAGES.PICK_STONE: return
	player_events.connect("projectile_thrown", self, "_on_player_projectile_thrown")
	PickStoneTutorial.visible = false
	tutorial_stage = TUTORIAL_STAGES.SHOOTING
	ShootingTutorial.show()

	
## Shooting tutorial

func _on_player_projectile_thrown():
	if tutorial_stage != TUTORIAL_STAGES.SHOOTING: return
	ShootingTutorial.hide()
	tutorial_stage = TUTORIAL_STAGES.HUNGER
	HungerTutorial.show()
	HungerTimer.start()
	

## Hunger Tutorial

func _on_hunger_timer_timeout():
	if tutorial_stage != TUTORIAL_STAGES.HUNGER: return
	HungerTutorial.hide()
	tutorial_stage = TUTORIAL_STAGES.EATING
	player_events.connect("special_attack_available", self, "_on_player_special_attack_available")
	player_events.connect("special_attack_unavailable", self, "_on_player_special_attack_unavailable")
	game_events.emit_signal("tutorial_finished")


## EATING TUTORIAL

func _on_player_special_attack_available():
	if tutorial_stage != TUTORIAL_STAGES.EATING: return
	EatingTutorial.show()
func _on_player_special_attack_unavailable(): 
	if tutorial_stage != TUTORIAL_STAGES.EATING: return
	EatingTutorial.hide()
