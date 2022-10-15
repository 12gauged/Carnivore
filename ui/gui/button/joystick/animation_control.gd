extends TextureRect


onready var JoystickButton := $button_pivot/TouchScreenButton
onready var SpinningButtonAnimPlayer := $button_pivot/tutorial_stick_pivot/AnimationPlayer
onready var JoystickTutorialButtonPivot := $button_pivot/tutorial_stick_pivot


func play_tutorial_animation():
	JoystickButton.modulate.a = 0.0
	JoystickTutorialButtonPivot.show()
	SpinningButtonAnimPlayer.play("spin")
	
func stop_playing_tutorial_animation():
	JoystickButton.modulate.a = 1.0
	JoystickTutorialButtonPivot.hide()
	SpinningButtonAnimPlayer.stop()
