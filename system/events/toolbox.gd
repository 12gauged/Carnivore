extends Node


const DEFAULT_CAMERA_SMOOTHING_SPEED = 8


var SystemRNG: RandomNumberGenerator = RandomNumberGenerator.new()
var EntityRNG: RandomNumberGenerator = RandomNumberGenerator.new()
var WorldRNG: RandomNumberGenerator = RandomNumberGenerator.new()


func get_node_in_group(group_name: String):
	var SceneTreeNode = get_tree()
	var node
	var nodes_in_group
	if SceneTreeNode.has_group(group_name):
		nodes_in_group = SceneTreeNode.get_nodes_in_group(group_name)
		if len(nodes_in_group) > 1:
			nodes_in_group.pop_front()
		node = nodes_in_group[0]
	return node
	
	
onready var callers: Dictionary = {
	"toolbox": toolbox,
	"game_events": game_events,
	"gui_events": gui_events,
	"player_events": player_events,
	"input_events": input_events,
	"game_functions": game_functions,
	"game_data": game_data,
	"json_data_manager": json_data_manager
}
func call_global_method(method: Dictionary):
	if !method.has("args"): 
		callers[method.caller].call(method.method)
		return
		
	var caller = method.caller
	var method_ref = method.method
	var args = method.args.duplicate()
	
	args = format_args(args)
	
	match len(args):
		1: callers[caller].call(method_ref, args[0])
		2: callers[caller].call(method_ref, args[0], args[1])
		3: callers[caller].call(method_ref, args[0], args[1], args[2])
		4: callers[caller].call(method_ref, args[0], args[1], args[2], args[3])
		5: callers[caller].call(method_ref, args[0], args[1], args[2], args[4], args[5])
	
func format_args(args: Array) -> Array:
	var formatted_args = args.duplicate()
	
	# uuhh UUHHH uhh 
	for arg in formatted_args:
		var arg_id = formatted_args.find(arg)
		if typeof(arg) == TYPE_STRING:
			if "var." in arg:
				var argument = [""]
				var id = 0
				for c in arg: # UUHHHH idk
					if c != ".":
						argument[id] += c
					else:
						argument.append("")
						id += 1
				formatted_args[arg_id] = callers[argument[1]][argument[2]]
	return formatted_args
									   
func process_variable_request(variable, just_give_this_self):
	var state: int = 0 # 0 = target node  1 = variable name
	var variable_name = ""
	var variable_owner = ""
	
	for c in variable:
		match state:
			0:
				if c != ".": variable_owner += c
				else: state = 1
			1: variable_name += c
			
	if variable_name.empty():
		return just_give_this_self[variable_owner]
	return just_give_this_self[variable_owner][variable_name]
	
	
func vector_values_to_int(Vector: Vector2) -> Vector2: 
	return Vector2(int(Vector.x), int(Vector.y))
func vector_abs(vector: Vector2) -> Vector2:
	return Vector2(abs(vector.x), abs(vector.y))
func stepify_vector(Vector: Vector2, step: int) -> Vector2: 
	return Vector2(stepify(Vector.x, step), stepify(Vector.y, step))
func mirror_ceil(value: float):
	if value > 0: return ceil(value)
	else: return floor(value)
func toggle_bool(value: bool):
	return value == false
