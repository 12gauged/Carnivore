extends Node2D


signal music_finished


export(AudioStream) var music
onready var StreamSample = resources.get_resource("music", "music_sample")
onready var StreamGroup = toolbox.get_node_in_group("sound_streams")

func play():
	var NewStreamSample: AudioStreamPlayer = StreamSample.instance()
	NewStreamSample.stream = music
	NewStreamSample.bus = "music"
	StreamGroup.add_child(NewStreamSample)
	NewStreamSample.play()
	NewStreamSample.connect("finished", self, "_on_stream_finished")
	
	
func _on_stream_finished(): emit_signal("music_finished")
