extends Node2D


@export var parent_node: CharacterBody2D
var states: Dictionary = {}
var current_state: State
var current_state_name: String


func _ready() -> void:
	for child in get_children():
		if not child is State: continue
		var state_name = child.name.to_snake_case()
		if current_state_name == "": 
			current_state_name = state_name
			current_state = child
		child.set_parent_node(parent_node)
		states[state_name] = child
	current_state._on_state_entered()


func _process(delta) -> void:
	if not is_instance_valid(current_state): return
	current_state.execute(delta)


func _physics_process(delta):
	if not is_instance_valid(current_state): return
	current_state.execute_physics(delta)


func move_to_next_state() -> void:
	if is_instance_valid(current_state):
		current_state._on_state_exited()
	
	var next_state = (states.keys().find(current_state_name) + 1)
	var next_state_id = next_state % len(states)
	current_state_name = states.keys()[next_state_id]
	current_state = states[current_state_name]
	current_state._on_state_entered()
