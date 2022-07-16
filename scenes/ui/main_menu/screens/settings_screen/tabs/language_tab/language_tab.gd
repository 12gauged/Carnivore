extends VBoxContainer


func _on_language_button_pressed(id):
	game_data.set_game_setting("locale", "value", id)
	json_data_manager.save_settings()
	TranslationServer.set_locale(id)
