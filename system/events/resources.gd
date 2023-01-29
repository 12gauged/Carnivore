extends Node
	
func get_resource(group, key): return resources[group][key]
	
var resources: Dictionary = {
	"sprites": {
		"player": preload("res://entities/player/player.png"),
		"player_dead": preload("res://entities/player/player_dead.png"),
		"ant": preload("res://entities/ant/ant.png"),
		"ant_hands_up_overlay": preload("res://entities/ant/ant_hands_up_overlay.png"),
		"frog": preload("res://entities/frog/frog.png"),
		"ant_soldier": preload("res://entities/ant_soldier/ant_soldier.png"),
		"fire_ant": preload("res://entities/fire_ant/fire_ant.png"),
		"fire_ant_fire_overlay": preload("res://entities/fire_ant/fire_overlay.png"),
		
		"meat_drop": preload("res://entities/drops/meat/meat.png"),
		"stone_drop": preload("res://entities/drops/stone/stone_drop.png"),
		
		"stone_projectile": preload("res://projectiles/stone/stone_projectile.png"),
		"pickup_particle": preload("res://particles/pickup/pickup_particle.png"),
		
		"mushroom_house0": preload("res://world/level1/houses/mushroom_house_short.png"),
		"mushroom_house1": preload("res://world/level1/houses/mushroom_house_tall.png"),
		"mouse_textures": {
			0: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_none.png"),
			1: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_left.png"),
			2: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_right.png"),
			3: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_middle.png"),
			8: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_xbutton1.png"),
			9: preload("res://ui/gui/mouse/mouse_indicator/mouse_indicator_xbutton2.png")
		}
	},
	"sounds": {
		"sample": preload("res://sounds/audio_stream_sample.tscn"),
		"enemy_hit": preload("res://sounds/entity/enemy/enemy_hit.wav"),
		"player_bite": preload("res://sounds/entity/player/player_bite.wav"),
		"player_hit": preload("res://sounds/entity/player/player_hit.wav"),
		"player_throw": preload("res://sounds/entity/player/player_throw.wav")
	},
	"music": {
		"music_sample": preload("res://sounds/music_stream_sample.tscn"),
		"ant_raid": preload("res://music/ant_raid/ant_raid.ogg")
	},
	"scenes": {
		"debug": preload("res://scenes/levels/dev/debug.tscn"),
		"main": preload("res://main.tscn"),
		
		"main_menu": preload("res://scenes/ui/main_menu/main_menu.tscn"),
		"death_screen": preload("res://scenes/ui/death_screen/death_screen.tscn"),
		"village_saved_screen": preload("res://scenes/ui/village_saved_screen/village_saved_screen.tscn"),
		
		"level1": preload("res://scenes/levels/level1/level1.tscn"),
		"jail": preload("res://scenes/levels/jail/jail.tscn"),
		"arena": preload("res://scenes/levels/arena/arena.tscn"),
		
		"intro": preload("res://scenes/ui/intro/intro.tscn")
	},
	"entities": {
		"player": preload("res://entities/player/player.tscn"),
		"ant": preload("res://entities/ant/ant.tscn"),
		"frog": preload("res://entities/frog/frog.tscn"),
		"worm": preload("res://entities/worm/worm.tscn"),
		"ant_soldier": preload("res://entities/ant_soldier/ant_soldier.tscn"),
		"fire_ant": preload("res://entities/fire_ant/fire_ant.tscn"),
		
		"stone_projectile": preload("res://projectiles/stone/stone_projectile.tscn"),
		"spear_projectile": preload("res://projectiles/spear/spear_projectile.tscn"),
		"fire_area": preload("res://projectiles/fire_area/fire_area.tscn"),
		
		"saving_flag": preload("res://entities/saving_flag/saving_flag.tscn"),
		
		"stone_drop": preload("res://entities/drops/stone/stone_drop.tscn"),
		"meat_drop": preload("res://entities/drops/meat/meat.tscn")
	},
	"particles": {
		"pickup": preload("res://particles/pickup/pickup_particle.tscn"),
		"entity_death": preload("res://particles/entity/entity_death_particle.tscn"),
		"entity_ground_slam": preload("res://particles/entity/entity_ground_slam_particle.tscn"),
		"bounty_indicator": preload("res://particles/entity/bounty_indicator.tscn"),
		"progress_saved_indicator": preload("res://particles/entity/progress_saved_indicator.tscn")
	}
}
