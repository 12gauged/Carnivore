extends MenuScreen

const ARCHIEVEMENT_TITLE_BASE: String = "ui.archievements.%s.title"
const ARCHIEVEMENT_DESCRIPTION_BASE: String = "ui.archievements.%s.description"

onready var CurrentArchievement = $archievement_viewer_manager/archievement_container/current_archievement
onready var ArrowLeft = $archievement_viewer_manager/archievement_container/arrow_left
onready var ArrowRight = $archievement_viewer_manager/archievement_container/arrow_right
onready var TabOutOfFocusRight = $tabs_out_of_focus/right
onready var TabOutOfFocusLeft = $tabs_out_of_focus/left


export(int) var number_of_archievements = 3
var current_panel: int = 0
var current_generation: String = "generation%s"
var archievements = game_data.get_player_data("archievements")


func _ready(): 
	current_generation = current_generation % game_data.get_player_data("generation")
	number_of_archievements -= 1 # improves readability
	update_current_panel()


func update_current_panel():
	
	var archievement = game_data.ARCHIEVEMENT_REF[current_generation][current_panel]
	var archievement_title = ARCHIEVEMENT_TITLE_BASE % archievement
	var archievement_description = ARCHIEVEMENT_DESCRIPTION_BASE % archievement
	
	CurrentArchievement.set_archievement(archievement_title, archievement_description)
	
	if archievements[current_generation][archievement]: # if the archievement is complete
		CurrentArchievement.mark_archievement_as_complete()
	else: CurrentArchievement.mark_archievement_as_incomplete()
	
	ArrowLeft.disabled = current_panel == 0
	ArrowRight.disabled = current_panel == number_of_archievements
	
	TabOutOfFocusRight.visible = current_panel < number_of_archievements
	TabOutOfFocusLeft.visible = current_panel > 0


func _on_arrow_button_pressed(id):
	match id:
		"arrow_left": current_panel = max(0, current_panel - 1)
		"arrow_right": current_panel = min(number_of_archievements, current_panel + 1)
	update_current_panel()
