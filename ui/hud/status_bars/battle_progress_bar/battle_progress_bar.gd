extends TextureProgress


var current_wave = 0

func _ready():
	game_events.connect("wave_finished", self, "_on_wave_ended")
	value = 0
	
func _process(delta):
	if value < current_wave:
		value += 5 * delta
	else: value = current_wave
	
func _on_wave_ended(): 
	current_wave += 1
