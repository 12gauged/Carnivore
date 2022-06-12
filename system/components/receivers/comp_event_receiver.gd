extends Component

signal event_received

export(String) var emitter = ""
export(String) var event = ""



func _ready():
	var event_emitter = toolbox.callers[emitter]
	event_emitter.connect(event, self, "_on_event_received")
	
	

func _on_event_received():
	emit_signal("event_received")
