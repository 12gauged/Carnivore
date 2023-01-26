extends AnimationPlayer

export(String) var animation_to_play = ""
export(bool) var auto_play = false

func _ready(): if auto_play: play_anim()
func play_anim(): play(animation_to_play)
