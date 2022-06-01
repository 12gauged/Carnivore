extends AudioStreamPlayer2D

func _on_audio_stream_sample_finished(): queue_free()
