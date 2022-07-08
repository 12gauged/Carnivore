extends Area2D
class_name DetectionBox

onready var Collision: CollisionShape2D = $CollisionShape2D

export(bool) var disabled = false
export(Array) var TAGS = []
export(Array) var ACCEPT_TAGS = []
export(Array) var IGNORE_TAGS = []

onready var Owner = get_parent()

func _ready(): Collision.set_deferred("disabled", disabled)

func _disable_request(): 
	Collision.set_deferred("disabled", true)
func _enable_request():
	Collision.set_deferred("disabled", false)
	
func is_area_valid(area) -> bool:
	if IGNORE_TAGS.empty(): return true
	
	for tag in area.TAGS:
		if tag in IGNORE_TAGS: 
			return false
	return true
