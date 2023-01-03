extends TouchScreenButton


## Thanks to Gonkee for providing the tutorial for this joystick!
## YouTube channel: https://www.youtube.com/channel/UCJqCPFHdbc6443G3Sz6VYDw
## Video I watched: https://www.youtube.com/watch?v=uGyEP2LUFPg&t=0s

signal joystick_pressed
signal joystick_released
signal joystick_in_use
signal joystick_returned

export(String) var input_event = "player_movement_direction_updated"
export(bool) var read_touches = true

onready var ButtonPivot: Position2D = get_parent()
onready var Joystick: TextureRect = ButtonPivot.get_parent()
onready var button_radius: Vector2 = Vector2(8, 8) * global_scale

var joystick_boundary: int = 18
var ongoing_drag: int = -1
var distance_from_pivot: float
var position_difference: Vector2
var return_acceleration = 20
var threshold: int = 5
var last_value: Vector2


func _ready():
	if game_data.current_platform == "mobile": return
	set_process_input(false)
	set_process(false)


func _input(event: InputEvent):
	
	if read_touches: set_joystick_position_from_drag_and_touch(event)
	else: set_joystick_position_from_drag(event)
	
	if not(event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag): return
	ongoing_drag = -1
	input_events.emit_signal(input_event, Vector2.ZERO)
	
	var signal_to_emit = "joystick_released" if get_button_position().length() > threshold else "joystick_returned"
	emit_signal(signal_to_emit)

func _process(delta):
	if ongoing_drag == -1:
		position_difference = (Vector2.ZERO - button_radius) - position
		position += position_difference * return_acceleration * delta
		
		

func set_joystick_position_from_drag_and_touch(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch and event.is_pressed():
		distance_from_pivot = get_distance_from_pivot(event.position)
		if distance_from_pivot <= joystick_boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - button_radius)
			set_joystick_position()
			ongoing_drag = event.get_index()
			input_events.emit_signal(input_event, get_value())
			emit_signal("joystick_in_use")

func set_joystick_position_from_drag(event):
	if event is InputEventScreenDrag:
		distance_from_pivot = get_distance_from_pivot(event.position)
		if distance_from_pivot <= joystick_boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - button_radius)
			set_joystick_position()
			ongoing_drag = event.get_index()
			
			if get_button_position().length() > threshold:
				emit_signal("joystick_pressed")
				emit_signal("joystick_in_use")
				input_events.emit_signal(input_event, get_value())
				return


func set_joystick_position() -> void:
	if get_button_position().length() <= joystick_boundary: return
	position = get_button_position().normalized() * joystick_boundary - button_radius

func get_distance_from_pivot(event_position: Vector2) -> float:
	return (event_position - ButtonPivot.global_position).length()
func get_button_position() -> Vector2: return position + button_radius
	
func get_value() -> Vector2:
	if get_button_position().length() > threshold:
		return get_button_position().normalized()
	return Vector2.ZERO
