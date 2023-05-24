extends Sprite

onready var animation_player = $AnimationPlayer
onready var timer = $Timer


func _ready():
	update_timer_duration(game_data.get_cheer_intensity())
	timer.start()
	game_events.connect("cheer_intensity_updated", self, "_on_cheer_intensity_updated")
	
	
	
func update_timer_duration(cheer_intensity):
	randomize()
	timer.wait_time = rand_range(5.0, 10.0) / cheer_intensity	



func _on_Timer_timeout():
	update_timer_duration(game_data.get_cheer_intensity())
	timer.start()
	animation_player.play("cheer")	

func _on_cheer_intensity_updated(cheer_intensity: float):
	_on_Timer_timeout()
