extends Node2D


signal music_finished


export(AudioStream) var music

onready var Stream = $stream

func play():
	Stream.stream = music
	Stream.bus = "music"
	Stream.play()
	
func stop():
	Stream.stop()
	
	
func set_volume(value: float): Stream.volume_db = linear2db(value)
func get_volume() -> float: return db2linear(Stream.volume_db)
	
	
func _on_stream_finished(): emit_signal("music_finished")
