extends TextureProgressBar
class_name StatusBar


signal decreased
signal increased
signal updated(val: int)
@export var id: String = ""
@export var event_name: String = ""
var red_amount: float = 1.0
var flashing_red: bool = true


func _ready() -> void:
	if not event_name in HUDEvents:
		push_error("HUDEvents doesn't have signal %s" % event_name)
		return
	HUDEvents.get(event_name).connect(set_value_request)
	
	
func _physics_process(delta: float) -> void:
	if red_amount > 0.0 and flashing_red:
		red_amount -= delta * 3.5
	self.modulate.b = 1.0 - red_amount
	self.modulate.g = 1.0 - red_amount
	

func set_value_request(args) -> void:
	var val = args[0]
	var request_id = args[1]
	
	if request_id != id:
		return
		
	if val < value:
		decreased.emit()
	elif val > value:
		increased.emit()
	value = val
	updated.emit(value)
	
	
func turn_red() -> void:
	pass
	
	
func flash_red() -> void:
	red_amount = 1.0
