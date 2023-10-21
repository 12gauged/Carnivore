extends AnimationTree


@onready var playback: AnimationNodeStateMachinePlayback = self.get("parameters/playback")


func go_to_animation(animation_name: String) -> void:
	playback.travel(animation_name)
	
	
func activate() -> void:
	set_active(true)
	
	
func deactivate() -> void:
	set_active(false)
