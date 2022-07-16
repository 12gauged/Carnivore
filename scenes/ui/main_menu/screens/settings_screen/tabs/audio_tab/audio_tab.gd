extends VBoxContainer


onready var Sliders: Dictionary= {
	"entity_sounds": $entity_bus/HSlider,
	"environment_sounds": $environment_bus/HSlider,
	"Master": $master_bus/HSlider,
	"music": $music_bus/HSlider,
	"player_sounds": $player_bus/HSlider
}


func _ready():
	for VolumeSlider in Sliders.keys():
		Sliders[VolumeSlider].set_value(game_data.get_game_setting("audio", VolumeSlider))
		


func _on_slider_value_updated(id, value):
	var bus_id = AudioServer.get_bus_index(id)
	var value_in_db = linear2db(value)
	AudioServer.set_bus_volume_db(bus_id, value_in_db)
	json_data_manager.save_settings()
