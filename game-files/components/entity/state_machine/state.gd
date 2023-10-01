extends Node2D
class_name State


signal state_exited
signal state_entered
signal move_to_next_state
signal move_to_state(state_name)
var behaviors: Array[Behavior]
var parent_node: CharacterBody2D


func _on_state_entered() -> void:
	start_timers()
	event_state_entered()
	state_entered.emit()
	
	
func _on_state_exited() -> void:
	event_state_exited()
	state_exited.emit()


func execute(delta) -> void:
	if not behaviors.is_empty():
		for behavior in behaviors:
			behavior.execute(delta)
	
	
func execute_physics(delta) -> void:
	if not behaviors.is_empty():
		for behavior in behaviors:
			behavior.execute_physics(delta)
			
		
func event_state_entered() -> void:
	pass
	
	
func event_state_exited() -> void:
	pass
	
	
func start_timers() -> void:
	var children: Array[Node] = get_children()
	if children.is_empty(): return
	
	for child in children:
		if not child is Timer:
			continue
		child.start()
			
			
func set_parent_node(value: CharacterBody2D) -> void:
	parent_node = value
	if get_children().is_empty(): return
	for child in get_children():
		if not child is Behavior: continue
		behaviors.append(child)
		child.set_parent_node(parent_node)
