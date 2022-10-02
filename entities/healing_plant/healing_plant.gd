extends StaticBody2D

signal dead


onready var Txture = $texture
onready var AnimPlayer = $texture/AnimationPlayer
const NUMBER_OF_STAGES = 2
var current_state = -1

var id = 0


func _ready():
	player_events.connect("healed_by_plant", self, "_on_player_healed")
	
	
	
func _on_player_healed():
	current_state = min(current_state + 1, NUMBER_OF_STAGES)
	if current_state < 0: return
	Txture.frame = current_state
	
	if current_state == NUMBER_OF_STAGES:
		AnimPlayer.play("die")
		emit_signal("dead")
