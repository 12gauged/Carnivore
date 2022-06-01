extends Control

onready var HudElements = {
	"top_elements": $top_elements,
	"bottom_elements": $bottom_elements
}



func _ready():
	# warning-ignore:return_value_discarded
	gui_events.connect("hide_hud", self, "_on_hide_hud_request")
	# warning-ignore:return_value_discarded
	gui_events.connect("show_hud", self, "_on_show_hud_request")
	
	

func set_hud_element_visibility(element: String, value: bool):
	for key in HudElements.keys():
		if key == element or element == "all":
			HudElements[key].visible = value

	

func _on_hide_hud_request(): set_hud_element_visibility("all", false)
func _on_show_hud_request(): set_hud_element_visibility("all", true)
