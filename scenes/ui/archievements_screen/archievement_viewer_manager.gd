extends MenuScreen

const ARCHIEVEMENT_TITLE_BASE: String = "ui.challenges.%s.title"
const ARCHIEVEMENT_DESCRIPTION_BASE: String = "ui.challenges.%s.description"

onready var CurrentArchievement = $archievement_viewer_manager/CenterContainer/archievement_container/current_archievement
onready var ArrowDown = $archievement_viewer_manager/CenterContainer/archievement_container/arrow_down
onready var ArrowUp = $archievement_viewer_manager/CenterContainer/archievement_container/arrow_up
onready var TabOutOfFocusTop = $archievement_viewer_manager/CenterContainer/tab_top_container/tab_top
onready var TabOutOfFocusBottom = $archievement_viewer_manager/CenterContainer/tab_bottom_container/tab_bottom


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
	
	ArrowUp.disabled = current_panel == 0
	ArrowDown.disabled = current_panel == number_of_archievements
	
	TabOutOfFocusTop.visible = current_panel > 0
	TabOutOfFocusBottom.visible = current_panel < number_of_archievements


func _on_arrow_button_pressed(id):
	match id:
		"arrow_up": current_panel = int(max(0, current_panel - 1))
		"arrow_down": current_panel = int(min(number_of_archievements, current_panel + 1))
	update_current_panel()
