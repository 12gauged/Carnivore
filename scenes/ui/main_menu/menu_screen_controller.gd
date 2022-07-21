extends Control


onready var AnimPlayer: AnimationPlayer = $animation_player
onready var screens: Dictionary = {
	"main": $main,
	"settings": $settings,
	"credits": $credits,
	"challenges": $challenges_screen
}
onready var last_screen = screens.main


var target_screen: String = ""


func _input(event):
	if !OS.is_debug_build(): return
	
	if event.is_action_pressed("debug_f1"):
		game_events.emit_signal("change_scene_request", "debug")


func _ready():
	screens.main.visible = true
	screens.settings.visible = false
	screens.credits.visible = false



func go_to_screen(screen: String):
	target_screen = screen
	AnimPlayer.play("fade_out")

func go_to_main_screen(): go_to_screen("main")
func go_to_settings_screen(): go_to_screen("settings")
func go_to_credits_screen(): go_to_screen("credits")
func go_to_challenges_screen(): go_to_screen("challenges")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_out":
			last_screen.visible = false
			last_screen = screens[target_screen]
			last_screen.visible = true
			AnimPlayer.play("fade_in")
			
func _on_button_pressed(id): call("go_to_%s" % id)	
