extends Node2D


signal music_finished


export(AudioStream) var music
onready var StreamSample = resources.get_resource("music", "music_sample")
onready var StreamGroup = toolbox.get_node_in_group("sound_streams")

var NewStreamSample : AudioStreamPlayer

func play():
	NewStreamSample = StreamSample.instance()
	NewStreamSample.stream = music
	NewStreamSample.bus = "music"
	StreamGroup.add_child(NewStreamSample)
	NewStreamSample.play()
	# warning-ignore:return_value_discarded
	NewStreamSample.connect("finished", self, "_on_stream_finished")
	
func stop():
	if NewStreamSample == null: return
	NewStreamSample.queue_free()
	
	
func _on_stream_finished(): emit_signal("music_finished")
