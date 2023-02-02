extends Label


var texts: Array = [
	"ui.victory_text.you_win",
	"ui.victory_text.lucky",
	"ui.victory_text.almost_got_you",
	"ui.victory_text.impossible"
]

func _ready():
	toolbox.SystemRNG.randomize()
	var text_id = toolbox.SystemRNG.randi_range(0, len(texts) - 1)
	self.text = tr(texts[text_id])
