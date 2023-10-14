extends Node2D



func _ready() -> void:
	Game.play_sound_request.connect(play_sound)


func play_sound(stream: AudioStream) -> void:
	var new_sound_stream: AudioStreamPlayer = create_sound_stream()
	new_sound_stream.stream = stream
	new_sound_stream.play()
	
	
func create_sound_stream() -> AudioStreamPlayer:
	var new_sample: AudioStreamPlayer = AudioStreamPlayer.new()
	self.add_child(new_sample)
	new_sample.finished.connect(new_sample.queue_free)
	return new_sample
