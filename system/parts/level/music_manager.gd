extends Node2D

enum StreamModes {
	PLAY_ONCE,
	PLAY_LOOP,
	PLAY_RANDOM,
	PLAY_LOOP_RANDOM,
	QUEUE_LOOP
}

export var track_list: Array = []
export(StreamModes) var stream_mode = 0

onready var music_player = $music_player
onready var TRACK_LIST_LEN = len(track_list) - 1

var initial_random_track # used only by PLAY_LOOP_RANDOM

var track_id: int = 0
var track_loop: bool = false
var fade_out: bool = false

func _ready():
	game_events.connect("stop_music_fade_out", self, "stop_music_fade_out")
	game_events.connect("stop_music", self, "stop_music")
	
	if stream_mode == StreamModes.PLAY_LOOP_RANDOM:
		toolbox.SystemRNG.randomize()
		var random_track_id = toolbox.SystemRNG.randi_range(0, TRACK_LIST_LEN)
		initial_random_track = track_list[random_track_id]
	
	play_music()
	
	
func _physics_process(delta):
	if music_player.get_volume() <= 0: fade_out = false	
	if not fade_out: return
	music_player.set_volume(clamp(music_player.get_volume() - delta * 0.5, 0.0, 2.0))
	
	
func stop_music():
	music_player.stop()

func stop_music_fade_out():
	fade_out = true


func play_music():
	
	if track_list.empty():
		push_error("Music Manager track list is empty.")
		return
	
	var track
	
	match stream_mode:
		StreamModes.PLAY_ONCE:
			track = track_list[0]
		StreamModes.PLAY_LOOP:
			track = track_list[0]
			track_loop = true
		StreamModes.PLAY_RANDOM:
			toolbox.SystemRNG.randomize()
			track = track_list[toolbox.SystemRNG.randi_range(0, TRACK_LIST_LEN)]
			track_loop = true
		StreamModes.PLAY_LOOP_RANDOM:
			track = initial_random_track
			track_loop = true
		StreamModes.QUEUE_LOOP:
			track_id = track_id + 1 if track_id < TRACK_LIST_LEN else 0
			track = track_list[track_id]
			track_loop = true
			
	music_player.music = track
	music_player.play()



func _on_part_music_streamer_music_finished():
	if !track_loop: return
	play_music()
