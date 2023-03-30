extends Sprite


func _on_PlayerSensor_body_detected(): self.modulate = Color.yellow
func _on_PlayerSensor_body_left(): self.modulate = Color.white
