extends VBoxContainer


onready var Sliders: Dictionary= {
	"entity_bus": $entity_bus/HSlider,
	"environment_bus": $environment_bus/HSlider,
	"master_bus": $master_bus/HSlider,
	"music_bus": $music_bus/HSlider,
	"player_bus": $player_bus/HSlider
}


func _ready():
	for VolumeSlider in Sliders.keys():
		Sliders[VolumeSlider].set_value(game_data.get_game_setting("audio", VolumeSlider))
		


func _on_slider_value_updated(id, value):
	var bus_id = AudioServer.get_bus_index(id)
	var value_in_db = linear2db(value)
	AudioServer.set_bus_volume_db(bus_id, value_in_db)
