extends VBoxContainer

onready var loaded_locales = TranslationServer.get_loaded_locales()
onready var lang_node_ref: Dictionary = {
	"pt": $portuguese_button,
	"en": $english_button,
	"fr": $french_button,
	"fr_CA": $french_CA_button
}

var PreviouslyPressedButton: TextureButton


func _ready():
	PreviouslyPressedButton = lang_node_ref[get_loaded_locale(TranslationServer.get_locale())]
	PreviouslyPressedButton.pressed = true
	PreviouslyPressedButton.disabled = true


func _on_language_button_pressed(id):
	game_data.set_game_setting("locale", "value", id)
	json_data_manager.save_settings()
	TranslationServer.set_locale(id)
	
	PreviouslyPressedButton.disabled = false
	PreviouslyPressedButton.pressed = false
	
	PreviouslyPressedButton = lang_node_ref[id]
	PreviouslyPressedButton.disabled = true
	
	
func get_loaded_locale(user_locale: String) -> String:
	var result: String
	for locale in loaded_locales:
		if locale in user_locale:
			result = locale
	return result
