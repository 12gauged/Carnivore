extends VBoxContainer


onready var DisappearAnimationPlayer: AnimationPlayer = $disappear_animation_player
onready var DisappearTimer: Timer = $disappear_timer
onready var SkipButton: TextureButton = $skip_button
var touch_counter: int = 0



func _ready():
	SkipButton.visible = false



func _input(event):
	if not event is InputEventMouseButton: return
	
	if touch_counter == 1:
		touch_counter = 0
		SkipButton.visible = true
		SkipButton.modulate.a = 1.0
		DisappearTimer.start()
		return
	touch_counter += 1


func _on_disappear_timer_timeout():
	DisappearAnimationPlayer.play("disappear")
