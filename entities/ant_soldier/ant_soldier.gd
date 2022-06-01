extends StaticBody2D

# it isn't worth to use the entity class here because the ant soldier doesn't do
# anything besides starting the arena so yeah

signal flew_away

export(Array) var TAGS = ["IGNORE"]

onready var SpeechBubble: Sprite = $comp_interactable/speech_bubble
onready var AnimPlayer: AnimationPlayer = $animation_player
onready var CameraFocus: Position2D = $part_camera_focus
onready var ArenaStarter: Component = $comp_arena_starter


func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("text_box_skipped", self, "_on_text_box_skipped")


func _on_comp_interactable_interacted(): SpeechBubble.visible = false
func _on_text_box_skipped(): 
	AnimPlayer.play("fly_away")
	

func _on_animation_player_animation_finished(anim_name):
	match anim_name: 
		"fly_away": 
			CameraFocus.unfocus()
			ArenaStarter.start_arena()
			emit_signal("flew_away")
