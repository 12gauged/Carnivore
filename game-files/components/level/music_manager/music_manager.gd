extends Node2D


@export var stream: AudioStream
@export var autoplay: bool = true
@export var loop: bool = true
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	audio_stream_player.set_stream(stream)
	if loop:
		audio_stream_player.finished.connect(on_music_finished)
	if not autoplay:
		return
	play_music()
	
	
func play_music() -> void:
	audio_stream_player.play()
	
	
func on_music_finished() -> void:
	audio_stream_player.play()
