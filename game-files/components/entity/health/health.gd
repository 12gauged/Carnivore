extends Node


signal taken_damage
signal dead
signal healed
@export var max_health: int = 1:
	set = set_health,
	get = get_health
var health: int


func _ready():
	health = max_health
	
	
func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		dead.emit()
	
	
func get_health() -> int:
	return health
	
	
func heal(heal_amount: int) -> void:
	set_health(get_health() + heal_amount)
	healed.emit()
	

func take_damage(damage: int) -> void:
	set_health(get_health() - damage)
	taken_damage.emit()
