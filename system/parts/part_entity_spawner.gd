extends Node2D

signal entity_spawned(InstancedEntity)

export(String) var entity_name = ""
export(String) var entity_group = ""
export(String) var deletion_signal = ""
export(bool) var auto_spawn = false
export(int) var spawn_chance = 100

export(bool) var respawn = false
export(float) var respawn_delay = 2.0
export(Vector2) var respawn_radius = Vector2(0, 0)

export(Array) var values_to_set = []

onready var RespawnDelayTimer: Timer = $respawn_delay_timer
onready var Group = toolbox.get_node_in_group(entity_group)
	
	
func _ready():
	if auto_spawn: spawn_entity()
	elif respawn: RespawnDelayTimer.start(respawn_delay)


func get_spawn_offset() -> Vector2:
	var result: Vector2 = Vector2.ZERO
	toolbox.SystemRNG.randomize()
	result.x = toolbox.SystemRNG.randi_range(0, respawn_radius.x)
	result.y = toolbox.SystemRNG.randi_range(0, respawn_radius.y)
	return result

func can_spawn() -> bool:
	toolbox.SystemRNG.randomize()
	return toolbox.SystemRNG.randi_range(1, 100) <= spawn_chance

func set_entity(value: String): entity_name = value

func spawn_entity():
	if !can_spawn(): return
	
	var Scene: PackedScene = resources.get_resource("entities", entity_name)
	var InstancedEntity = Scene.instance()
	set_custom_values(InstancedEntity)
	Group.call_deferred("add_child", InstancedEntity)
	
	InstancedEntity.set_global_position(self.global_position + get_spawn_offset())
	
	if !deletion_signal.empty():
		InstancedEntity.call_deferred("connect", deletion_signal, self, "_on_instanced_entity_deleted")
	
	emit_signal("entity_spawned", InstancedEntity)
	
	return InstancedEntity

func set_custom_values(Instance):
	for value in values_to_set:
		Instance[value[0]] = value[1]
		
func set_spawn_chance(value: int):
	spawn_chance = value
	
func allow_auto_spawning(): 
	auto_spawn = true
	if respawn: RespawnDelayTimer.start(respawn_delay)
func stop_auto_spawning(): auto_spawn = false
		
		
func _on_instanced_entity_deleted():
	if respawn: RespawnDelayTimer.start(respawn_delay)

func _on_respawn_delay_timer_timeout():
	if !auto_spawn: return
	spawn_entity()
