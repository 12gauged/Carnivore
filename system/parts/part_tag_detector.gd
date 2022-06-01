extends DetectionBox

signal tag_detected
export(String) var mode = "and"

func _on_part_tag_detector_body_entered(body):
	if !"TAGS" in body: return
	
	match mode:
		"or":
			for tag in ACCEPT_TAGS:
				if tag in body.TAGS: emit_signal("tag_detected")
		"and":
			var result
			for tag in ACCEPT_TAGS:
				result = tag in body.TAGS
			if result == true: emit_signal("tag_detected")
