extends CanvasLayer

signal fade_out_finished
signal fade_in_finished

onready var AnimPlayer: AnimationPlayer = $animation_player
var default_fade_speed: int = 1.0



func fade_out() -> void:
	AnimPlayer.play("fade_out")
func fade_in() -> void:
	AnimPlayer.play("fade_in")	
func set_fading_speed(speed: float) -> void:
	AnimPlayer.playback_speed = speed


func _on_animation_player_animation_finished(anim_name):
	gui_events.emit_signal("black_overlay_anim_finished", anim_name)
	match anim_name:
		"fade_out": 
			emit_signal("fade_out_finished")
			set_fading_speed(default_fade_speed)
		"fade_in": 
			emit_signal("fade_in_finished")
