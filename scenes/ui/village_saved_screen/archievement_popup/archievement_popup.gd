extends TextureRect

onready var ColorTween: Tween = $Tween
onready var TitleLabel: Label = $container/title_label


func _ready(): self.visible = false
	
	
	
func set_text(text: String): TitleLabel.text = text
	
func animate():
	self.modulate = Color.yellow
	ColorTween.interpolate_property(
		self,
		"modulate",
		Color.yellow, Color.white,
		0.4, 
		Tween.TRANS_LINEAR, Tween.EASE_OUT,
		0.8
	)
	ColorTween.start()
