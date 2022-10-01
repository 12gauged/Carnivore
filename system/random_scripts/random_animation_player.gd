extends AnimationPlayer


export(bool) var auto_play = false

onready var ANIMATION_LIST = get_animation_list()
onready var ANIMATION_LIST_LEN = len(ANIMATION_LIST)

func _ready():
	if auto_play: play_random()
	
func play_random():
	toolbox.SystemRNG.randomize()
	play(ANIMATION_LIST[toolbox.SystemRNG.randi_range(0, ANIMATION_LIST_LEN - 1)])
	
func stop_playing():
	stop(true)
		
