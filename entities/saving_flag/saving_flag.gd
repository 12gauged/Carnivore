extends Node2D

signal deleted

const SPRITE_SIZE_Y = 21
const PROGRESS_MODIFIER = 2
const DARK_GRAY = Color(0.25, 0.25, 0.25, 1.0)
const GRAY = Color(0.5, 0.5, 0.5, 1.0)

onready var LifetimeTimer: Timer = $lifetime_timer
onready var FlagOverlay: Sprite = $flag_overlay
onready var FlagSprite: Sprite = $flag_sprite
onready var AreaSprite: Sprite = $saving_area/area_sprite

onready var BlinkAnimationPlayer: AnimationPlayer = $blink_animation_player

var player_inside_area: bool = false



func _ready():
	FlagOverlay.region_rect.size.y = 0
	
	
	
func _physics_process(delta):
	
	FlagSprite.modulate = GRAY if FlagOverlay.region_rect.size.y > 0 else Color.white
	
	if FlagOverlay.region_rect.size.y == SPRITE_SIZE_Y:
		game_saved()
	
	if player_inside_area:
		FlagOverlay.region_rect.size.y += PROGRESS_MODIFIER * delta
		FlagOverlay.region_rect.size.y = clamp(FlagOverlay.region_rect.size.y, 0, SPRITE_SIZE_Y)
		return
		
	if 	FlagOverlay.region_rect.size.y == 0.0: return
	FlagOverlay.region_rect.size.y -= PROGRESS_MODIFIER * delta
	FlagOverlay.region_rect.size.y = clamp(FlagOverlay.region_rect.size.y, 0, SPRITE_SIZE_Y)



func game_saved():
	game_data.set_player_data("bounty", game_data.level_player_bounty)
	global_data_manager.save_player_data()
	emit_signal("deleted")
	queue_free()



func _on_saving_area_body_entered(_body):
	LifetimeTimer.paused = true
	player_inside_area = true
	AreaSprite.modulate = Color.yellow

func _on_saving_area_body_exited(_body):
	LifetimeTimer.paused = false
	player_inside_area = false
	AreaSprite.modulate =  DARK_GRAY

func _on_lifetime_timer_timeout():
	BlinkAnimationPlayer.play("blink")

func _on_blink_animation_player_animation_finished(_anim_name):
	queue_free()
