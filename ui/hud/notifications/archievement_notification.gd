extends TextureRect


const ARCHIEVEMENT_TITLE_TEXT: String = "ui.archievements.%s.title"
onready var ColorTween: Tween = $Tween
onready var TitleLabel: Label = $HBoxContainer/Label



func _ready():
	self.visible = false
	player_events.connect("archievement_made", self, "_on_archievement_made")
	


func animate():
	self.modulate = Color.yellow
	ColorTween.interpolate_property(
		self,
		"modulate",
		Color.yellow, Color.white,
		0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT,
		1.5
	)
	ColorTween.start()


	
func _on_archievement_made(archievement: String, notify):
	if !notify: return
	self.visible = true
	TitleLabel.text = archievement
	animate()

func _on_Tween_tween_all_completed():
	self.visible = false
