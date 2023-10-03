@tool
extends Node2D
class_name Level


func _ready():
	if Engine.is_editor_hint():
		self.add_to_group("levels", true)
		create_node_group("objects")
		create_node_group("projectiles")
		create_node_group("particles")
		return
		
	
func create_node_group(group_name: String, ysort: bool = false) -> void:
	var group_name_pascal = group_name.to_pascal_case()	
	if has_node(group_name_pascal): return
	
	var NewGroup: Node2D = Node2D.new()
	NewGroup.name = group_name_pascal
	NewGroup.y_sort_enabled = ysort
	NewGroup.add_to_group(group_name, true)
	
	add_child(NewGroup)
	NewGroup.set_owner(get_tree().get_edited_scene_root())
