extends Node2D
class_name Shooter


signal projectile_spawned
@export_enum("enemy_projectiles", "player_projectiles") var projectile_group: String = "enemy_projectiles"
@export var projectile_data: ProjectileData:
	set = set_projectile_data,
	get = get_projectile_data
var direction: Vector2 = Vector2.ZERO:
	set = set_direction,
	get = get_direction
@onready var projectiles_group: Node2D = get_tree().get_first_node_in_group("projectiles")


func spawn_projectile() -> void:
	if projectile_data == null: return
	var NewProjectile: Projectile = projectile_data.projectile_scene.instantiate()
	projectiles_group.add_child(NewProjectile)
	NewProjectile.global_position = get_global_position()
	NewProjectile.set_direction(direction)
	NewProjectile.get_hitbox().add_to_group(projectile_group)
	projectile_spawned.emit()
	
	
func shoot() -> void:
	spawn_projectile()
	
	
func set_direction(value: Vector2) -> void:
	direction = value
	
	
func get_direction() -> Vector2:
	return direction
	

func set_projectile_data(value: ProjectileData) -> void:
	projectile_data = value
	
	
func get_projectile_data() -> ProjectileData:
	return projectile_data
