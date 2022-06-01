extends Node2D

export(float) var duration = 0.5
export(float) var intensity = 0.1

func shake_camera(): camera_events.emit_signal("camera_shake_request", duration, intensity)
