extends GridContainer

signal logo_pressed(id)


var urls = {
	"evo": "https://twitter.com/934Evoli",
	"icedmi": "https://twitter.com/icedmi",
	"fryg": "https://twitter.com/FrygTm",
	"felipe": "https://twitter.com/felipe_does_pxl"
}


func _on_credit_pressed(btn_id):
	# warning-ignore:return_value_discarded
	OS.shell_open(urls[btn_id])


func _on_12gauged_logo_pressed():
	emit_signal("logo_pressed", "the_truth")
