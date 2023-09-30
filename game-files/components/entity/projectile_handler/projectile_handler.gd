extends Node2D


signal projectile_being_held(data)
signal projectile_thrown


var current_projectile_data: ProjectileData


func _unhandled_input(event):
	match event.get_class():
		"InputEventMouseButton":
			if event.button_index == MOUSE_BUTTON_LEFT:
				spawn_projectile()	


func _on_pickup_area_drop_collected(drop_data: DropData):
	if drop_data.type != "projectile": return
	current_projectile_data = drop_data
	projectile_being_held.emit(current_projectile_data)
	
	
func spawn_projectile() -> void:
	if current_projectile_data == null: return
	
	var NewProjectile: Projectile = current_projectile_data.projectile_scene.instantiate()
	var direction_to_mouse: Vector2 = get_global_position().direction_to(get_global_mouse_position())
	
	add_child(NewProjectile)
	NewProjectile.global_position = get_global_position()
	NewProjectile.set_direction(direction_to_mouse)
	
	current_projectile_data = null
	projectile_thrown.emit()
