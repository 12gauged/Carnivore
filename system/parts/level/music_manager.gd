extends Node2D

enum StreamModes {
	PLAY_ONCE,
	PLAY_LOOP,
	RANDOMIZED_LOOP,
	QUEUE_LOOP
}

export var track_list: Array = []
export(StreamModes) var stream_mode = 0

onready var music_player = $music_player
onready var TRACK_LIST_LEN = len(track_list) - 1

var track_id: int = 0
var track_loop: bool = false

func _ready(): 
	play_music()


func play_music():
	
	if track_list.empty():
		push_error("Music Manager track list is empty.")
		return
	
	toolbox.SystemRNG.randomize()
	
	var track
	
	match stream_mode:
		StreamModes.RANDOMIZED_LOOP:
			track = track_list[toolbox.SystemRNG.randi_range(0, TRACK_LIST_LEN)]
			track_loop = true
		StreamModes.QUEUE_LOOP:
			track_id = track_id + 1 if track_id < TRACK_LIST_LEN else 0
			track = track_list[track_id]
			track_loop = true
		StreamModes.PLAY_ONCE:
			track = track_list[0]
		StreamModes.PLAY_LOOP:
			track = track_list[1]
			track_loop = true
	music_player.music = track
	music_player.play()



func _on_part_music_streamer_music_finished():
	if !track_loop: return
	play_music()
