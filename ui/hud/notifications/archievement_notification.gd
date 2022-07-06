extends TextureRect


const ARCHIEVEMENT_TITLE_TEXT: String = "ui.archievements.%s.title"
onready var ColorTween: Tween = $Tween
onready var TitleLabel: Label = $HBoxContainer/Label



func _ready():
	self.visible = false
	# warning-ignore:return_value_discarded
	gui_events.connect("notify_archievement", self, "_on_archievement_notify_request")
	


func animate():
	self.modulate = Color.yellow
	# warning-ignore:return_value_discarded
	ColorTween.interpolate_property(
		self,
		"modulate",
		Color.yellow, Color.white,
		0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT,
		1.5
	)
	# warning-ignore:return_value_discarded
	ColorTween.start()


	
func _on_archievement_notify_request(archievement: String, notify: bool):
	if !notify: return	
	self.visible = true
	TitleLabel.text = tr(ARCHIEVEMENT_TITLE_TEXT % archievement)
	animate()

func _on_Tween_tween_all_completed():
	self.visible = false
