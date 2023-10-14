extends Node


signal health_restored(value)
signal hunger_restored(value)
signal energy_restored(value)


func on_drop_collected(drop_data: DropData) -> void:
	if drop_data.type != "consumable":
		return
		
	# Calls one of the "x_restored" signals
	# based on the restore value
	var to_restore: String = drop_data.restore
	get("%s_restored" % to_restore).emit(drop_data.restore_amount)
