extends InputHint

export(String) var key_label_text = ""
onready var KeyLabel: Label = $vertical_container/center_container/grid/button_background/key_label


func _ready():
	KeyLabel.text = key_label_text
