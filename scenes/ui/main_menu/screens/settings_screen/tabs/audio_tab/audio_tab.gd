extends VBoxContainer


func _on_slider_value_updated(id, value):
	var bus_id = AudioServer.get_bus_index(id)
	var value_in_db = linear2db(value)
	AudioServer.set_bus_volume_db(bus_id, value_in_db)
