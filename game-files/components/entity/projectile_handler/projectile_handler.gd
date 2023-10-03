extends Node2D


signal projectile_being_held(data)
signal projectile_thrown

@export var shooter: Shooter
var current_projectile_data: ProjectileData


func _unhandled_input(event) -> void:
	match event.get_class():
		"InputEventMouseButton":
			if event.button_index == MOUSE_BUTTON_LEFT:
				throw_projectile()


func _on_pickup_area_drop_collected(drop_data: DropData) -> void:
	if drop_data.type != "projectile": return
	current_projectile_data = drop_data
	projectile_being_held.emit(current_projectile_data)
	shooter.set_projectile_data(drop_data)
	
	
func throw_projectile() -> void:
	var direction = self.global_position.direction_to(get_global_mouse_position())
	shooter.set_direction(direction)
	shooter.shoot()
	shooter.set_projectile_data(null)
	

func _on_shooter_projectile_spawned() -> void:
	projectile_thrown.emit()
	
