extends TextureRect

onready var AnimPlayer: AnimationPlayer = $AnimationPlayer

func play_empty_anim():
	AnimPlayer.play("empty")
func play_fill_anim():
	AnimPlayer.play("fill")
