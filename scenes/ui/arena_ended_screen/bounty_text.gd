extends Label

signal bounty_animation_finished

const START_DELAY: float = 1.0

var DEFAULT_TEXT = "ui.bounty_text_during_animation"
var FINISHED_TEXT = "ui.bounty_text_after_animation"
const MINIMUM_INCREASE_DELAY: float = 0.1
const NUMBER_OF_ADDITIONS: float = 15.0

onready var initial_bounty: int = game_data.initial_player_bounty
onready var acquired_bounty: int = game_data.level_player_bounty

onready var YellowFlash = $yellow_flash
onready var IncreaseTimer: Timer = $increase_timer

var bounty_counter: float = 0.0

func _ready():
	self.text = tr(DEFAULT_TEXT) % [initial_bounty, bounty_counter]
	yield(get_tree().create_timer(START_DELAY), "timeout")
	IncreaseTimer.start()

func _on_increase_timer_timeout():
	if bounty_counter >= acquired_bounty:
		self.text = tr(FINISHED_TEXT) % [initial_bounty + acquired_bounty]
		YellowFlash.play("flash")
		emit_signal("bounty_animation_finished")
		return
		
	bounty_counter = int(min(bounty_counter + acquired_bounty / NUMBER_OF_ADDITIONS, acquired_bounty))
	self.text = tr(DEFAULT_TEXT) % [initial_bounty, bounty_counter]
	
	#var timer_duration: float = max(stepify(IncreaseTimer.wait_tim, 0.05), MINIMUM_INCREASE_DELAY)
	IncreaseTimer.start()
	
