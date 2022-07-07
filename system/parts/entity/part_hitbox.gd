extends DetectionBox

signal hit_detected(Hurtbox)

export(int) var damage
export(bool) var override_invincibility = false
export(bool) var continuous_hits = false
export(float) var hit_delay = 1.0


onready var SceneTreeNode = get_tree()
var DetectedArea
var time_counter: float


func _ready():
	set_physics_process(continuous_hits)
	
func _physics_process(delta):
	if !is_instance_valid(DetectedArea): return
	if time_counter >= hit_delay:
		DetectedArea.emit_signal("hit_detected", self)
		DetectedArea.emit_signal("play_hit_sound_request")
		time_counter = 0
		return
	time_counter += 0.1


func _on_part_hitbox_area_entered(area):
	if !area is DetectionBox: return
	if !is_area_valid(area): return
	
	DetectedArea = area
	emit_signal("hit_detected", area)

func _on_part_hitbox_area_exited(_area):
	time_counter = 0
	DetectedArea = null
