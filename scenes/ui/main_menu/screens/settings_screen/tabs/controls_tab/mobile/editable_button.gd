extends TouchScreenButton

export(NodePath) var margin_x
export(NodePath) var margin_y

var margins := Vector2.ZERO

onready var MarginX = get_node(margin_x)
onready var MarginY = get_node(margin_y)


signal button_pressed(button)


func _ready(): 
	connect("pressed", self, "_on_button_down")
	

func set_margins(value: Vector2):
	MarginX.update_displacement(value)
	MarginY.update_displacement(value)

func get_margin_assigned_setting_key():
	return [MarginX.assigned_setting_value, MarginY.assigned_setting_value]
func get_margin_axis():
	return [MarginX.margin_axis, MarginY.margin_axis]

	
func _on_button_down():
	emit_signal("button_pressed", self)
