extends Node
	
func get_resource(group, key): return resources[group][key]
	
var resources: Dictionary = {
	"sprites": {
		"player": preload("res://entities/player/player.png"),
		"ant": preload("res://entities/ant/ant.png"),
		"frog": preload("res://entities/frog/frog.png"),
		
		"meat_drop": preload("res://entities/drops/meat/meat.png"),
		"stone_drop": preload("res://entities/drops/stone/stone_drop.png"),
		
		"stone_projectile": preload("res://projectiles/stone/stone_projectile.png"),
		"pickup_particle": preload("res://particles/pickup/pickup_particle.png"),
		
		"mushroom_house0": preload("res://world/level1/houses/mushroom_house_short.png"),
		"mushroom_house1": preload("res://world/level1/houses/mushroom_house_tall.png")
	},
	"sounds": {
		"sample": preload("res://sounds/audio_stream_sample.tscn"),
		"enemy_hit": preload("res://sounds/entity/enemy/enemy_hit.wav"),
		"player_bite": preload("res://sounds/entity/player/player_bite.wav"),
		"player_hit": preload("res://sounds/entity/player/player_hit.wav"),
		"player_throw": preload("res://sounds/entity/player/player_throw.wav")
	},
	"scenes": {
		"debug": preload("res://scenes/levels/dev/debug.tscn"),
		"main": preload("res://main.tscn"),
		
		"main_menu": preload("res://scenes/ui/main_menu/main_menu.tscn"),
		"death_screen": preload("res://scenes/ui/death_screen/death_screen.tscn"),
		"village_saved_screen": preload("res://scenes/ui/village_saved_screen/village_saved_screen.tscn"),
		
		"level1": preload("res://scenes/levels/level1/level1.tscn"),
		"level1_comic": preload("res://scenes/levels/level1/level1_comic.tscn")
	},
	"entities": {
		"player": preload("res://entities/player/player.tscn"),
		"ant": preload("res://entities/ant/ant.tscn"),
		"frog": preload("res://entities/frog/frog.tscn"),
		"worm": preload("res://entities/worm/worm.tscn"),
		
		"stone_projectile": preload("res://projectiles/stone/stone_projectile.tscn"),
		"stone_drop": preload("res://entities/drops/stone/stone_drop.tscn"),
		
		"meat_drop": preload("res://entities/drops/meat/meat.tscn")
	},
	"particles": {
		"pickup": preload("res://particles/pickup/pickup_particle.tscn"),
		"entity_death": preload("res://particles/entity/entity_death_particle.tscn"),
		"entity_ground_slam": preload("res://particles/entity/entity_ground_slam_particle.tscn"),
	}
}
