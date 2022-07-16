extends AudioStreamPlayer

# I know this is the same code as in audio_stream_sample
# but for some GOD DAMN reason AudioStreamPlayer2D does
# not inherit from AudioStreamPlayer, so i need to have
# a different script for both

func _on_music_stream_sample_finished(): queue_free()
