extends Node2D

export(AudioStream) var stream
export(String) var bus = "Master"
export(float, 0.0, 1.0) var volume = 1.0
onready var StreamSample = resources.get_resource("sounds", "sample")
onready var StreamGroup = toolbox.get_node_in_group("sound_streams")

func play_sound():
	var NewStreamSample: AudioStreamPlayer2D = StreamSample.instance()
	NewStreamSample.stream = stream
	NewStreamSample.volume_db = linear2db(volume)
	NewStreamSample.bus = bus
	NewStreamSample.global_position = self.global_position
	StreamGroup.add_child(NewStreamSample)
	NewStreamSample.play()
