extends Node


@export var sounds: Dictionary = {}
@onready var button_group: Array[Node] = get_tree().get_nodes_in_group("buttons")
@onready var special_button_group: Array[Node] = get_tree().get_nodes_in_group("special_buttons")



func _ready() -> void:
	GameEvents.scene_finished_changing.connect(update_button_groups)
	
	for button in button_group:
		button.pressed.connect(play_button_click)
	for special_button in special_button_group:
		special_button.pressed.connect(play_special_button_click)
		
		
func update_button_groups() -> void:
	await get_tree().create_timer(0.01).timeout
	
	button_group = get_tree().get_nodes_in_group("buttons")
	special_button_group = get_tree().get_nodes_in_group("special_buttons")
	
	print(button_group)
	
	for button in button_group:
		button.pressed.connect(play_button_click)
	for special_button in special_button_group:
		special_button.pressed.connect(play_special_button_click)
		
		
func play_button_click() -> void:
	play_sound("button_click")
	
	
func play_special_button_click() -> void:
	play_sound("special_button_click")


func play_sound(sound_key: String) -> void:
	var sound_file = sounds[sound_key]
	var new_sound_stream: AudioStreamPlayer = create_sound_stream()
	
	new_sound_stream.stream = sound_file
	new_sound_stream.play()
	
	
func create_sound_stream() -> AudioStreamPlayer:
	var new_sample: AudioStreamPlayer = AudioStreamPlayer.new()
	self.add_child(new_sample)
	
	new_sample.finished.connect(new_sample.queue_free)
	
	return new_sample
