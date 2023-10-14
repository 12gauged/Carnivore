extends Area2D


signal drop_collected
signal consumable_collected(consumable_data: ConsumableData)
signal projectile_collected(projectile_data: ProjectileData)
@export_enum("consumable", "projectile") var tracked_drop_type: String = "consumable"


func _on_area_entered(area: Drop) -> void:
	if area.get_data().type != tracked_drop_type: 
		return
	self.get("%s_collected" % tracked_drop_type).emit(area.get_data())
	drop_collected.emit()
	area.collected.emit()
	area.queue_free()
	
	
func disable() -> void:
	set_monitoring.call_deferred(false)
	
	
func enable() -> void:
	set_monitoring.call_deferred(true)
