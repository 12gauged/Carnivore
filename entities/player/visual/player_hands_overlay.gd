extends Sprite

func _ready(): self.visible = false
	
func _on_projectile_collected(): self.visible = true
func _on_projectile_thrown(): self.visible = false
