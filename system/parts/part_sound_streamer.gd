extends Node2D

export(AudioStream) var stream
export(String) var bus = "Master"
export(float, 0.0, 1.0) var volume = 1.0
export(String, "Normal", "2D") var sample_type = "2D"
onready var StreamSample2D = resources.get_resource("sounds", "sample")
onready var NormalStreamSample = resources.get_resource("sounds", "normal_sample")
onready var StreamGroup = toolbox.get_node_in_group("sound_streams")

func play_sound():
	
	var NewStreamSample
	match sample_type:
		"Normal": NewStreamSample = NormalStreamSample.instance()
		"2D": NewStreamSample = StreamSample2D.instance()
	
	NewStreamSample.stream = stream
	NewStreamSample.volume_db = linear2db(volume)
	NewStreamSample.bus = bus
	if sample_type == "2D": NewStreamSample.global_position = self.global_position
	
	StreamGroup.add_child(NewStreamSample)
	NewStreamSample.play()
