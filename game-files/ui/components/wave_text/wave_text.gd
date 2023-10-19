extends RichTextLabel


const default_text = "[center]WAVE %s![/center]"
@onready var show_duration: Timer = $ShowDuration


func _ready() -> void:
	GameEvents.wave_ended.connect(update_wave_text)
	self.visible = false


func update_wave_text(args: Array) -> void:
	var new_wave = args[0]
	set_text(default_text % new_wave)
	
	self.visible = true
	show_duration.start()
