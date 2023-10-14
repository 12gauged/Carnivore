@tool
extends Node2D
class_name Level


func _ready():
	if Engine.is_editor_hint():
		self.add_to_group("levels", true)
		create_node_group("objects", true)
		create_node_group("projectiles", true)
		create_node_group("particles")
		
		create_custom_node(preload("res://components/level/level_sound_manager/level_sound_manager.tscn"))
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
	
	
func create_custom_node(node_scene: PackedScene) -> void:
	var new_node = node_scene.instantiate()
	self.add_child(new_node)
	new_node.set_owner(get_tree().get_edited_scene_root())
