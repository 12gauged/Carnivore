extends HBoxContainer

export(NodePath) var margin1
export(String, "top", "bottom", "left", "right") var margin1_grow_direction = "top"
export(int) var margin1_value = 0
export(NodePath) var margin2
export(String, "top", "bottom", "left", "right") var margin2_grow_direction = "top"
export(int) var margin2_value = 0

onready var Margin1: MarginContainer = get_node(margin1)
onready var Margin2: MarginContainer = get_node(margin2)




func _ready():
	Margin1.add_constant_override("margin_%s" % margin1_grow_direction, margin1_value)
	Margin2.add_constant_override("margin_%s" % margin2_grow_direction, margin2_value)
