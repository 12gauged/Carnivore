extends TextureRect

onready var AnimPlayer: AnimationPlayer = $animation_player
onready var ColorAnimPlayer: AnimationPlayer = $color_animation_player
export(String) var status_id = ""
export(int) var initial_value = 0

onready var last_value: int = initial_value

func _ready():
	player_events.connect("status_value_update", self, "_on_player_status_value_update")


func play_empty_anim(): AnimPlayer.play("empty")
func play_fill_anim(): AnimPlayer.play("fill")
	
	
	
func _on_player_status_value_update(id, value, animate):
	if id != status_id: return
	if !animate: return
	
	if value > last_value:
		ColorAnimPlayer.play("yellow_flash")
	last_value = value
