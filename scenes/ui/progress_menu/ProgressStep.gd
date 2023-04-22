extends PanelContainer
tool

const DEFAULT_COMPLETION_TEXT = "%s/%s"
const GRAY = Color(0.5, 0.5, 0.5, 1.0)

enum STATES {
	LOCKED,
	UNLOCKED,
	OBTAINED
}


export(STATES) var state = STATES.LOCKED setget set_state
export(String) var type = "TypeLabel"
export(String) var title = "TitleLabel"
export(Resource) var EnemyData
export(int) var NeededBounty = 0

onready var TypeLabel = $VBoxContainer/Type
onready var TitleLabel = $VBoxContainer/Title
onready var CompletionLabel = $VBoxContainer/Completion


onready var number_of_steps: int = get_parent().get_child_count() - 1 # WE COUNT FROM 0!!!!
onready var step_id: int = get_parent().get_children().find(self)


var needed_bounty: int
var current_bounty: int


func _ready():
	set_type(type)
	set_title(title)
	
	if EnemyData != null:
		set_needed_bounty(EnemyData.min_bounty)
	else:
		set_needed_bounty(NeededBounty)
	set_current_bounty(game_data.get_player_data("bounty"))
	
	if current_bounty >= needed_bounty:
		state = STATES.OBTAINED
	
	if state == STATES.OBTAINED and step_id != number_of_steps: # if this isnt the last step
		get_parent().get_child(step_id + 1).state = STATES.UNLOCKED
		
	update_visuals()



func set_type(value: String):
	TypeLabel.text = value
	type = value
func set_title(value: String):
	TitleLabel.text = value
	title = value
func set_needed_bounty(value: int):
	needed_bounty = value
	update_completion_label()
func set_current_bounty(value: int): 
	current_bounty = value
	update_completion_label()
	
func set_state(value: int):
	state = value
	update_visuals()
	
	

func update_visuals():
	match state:
		STATES.LOCKED: self.modulate = GRAY
		STATES.UNLOCKED: self.modulate = Color.white
		STATES.OBTAINED: self.modulate = Color.yellow



func update_completion_label(): CompletionLabel.text = DEFAULT_COMPLETION_TEXT % [current_bounty, needed_bounty]
