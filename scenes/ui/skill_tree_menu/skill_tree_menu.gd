extends Control

signal opened_menu
signal exited_menu


const DEFAULT_TITLE = "ui.skill_menu.title"
const DEFAULT_DESCRIPTION = "ui.skill_menu.description"
const DEFAULT_POINTS_TEXT = "ui.skill_menu.points"
const DISABLED_BUTTON_COLOR = Color(0.5, 0.5, 0.5, 1.0)
const DARK_RED = Color(0.6, 0.0, 0.0, 1.0)


export(NodePath) var SkillButtonGroupPath
onready var SkillButtonGroup = get_node(SkillButtonGroupPath)

export(NodePath) var BuyButtonPath
onready var BuyButton = get_node(BuyButtonPath)

export(NodePath) var SkillTitlePath
onready var SkillTitle: Label = get_node(SkillTitlePath)

export(NodePath) var SkillDescriptionPath
onready var SkillDescription: Label = get_node(SkillDescriptionPath)

export(NodePath) var PointsLabelPath
onready var PointsLabel: Label = get_node(PointsLabelPath)


export(Dictionary) var SkillPathTextureNodes = {
	"hard_skin": [],
	"healing_meal": [],
	"body_armor": [],
	"survivor": [],
	"energy_saver": [],
	"bloodthirsty": [],
	"speed_boost": [],
	"large_tongue": [],
	"rooted": []
}


enum SKILLS {
	HARD_SKIN,
	HEALING_MEAL,
	BODY_ARMOR,
	SURVIVOR,
	ENERGY_SAVER,
	BLOODTHIRSTY,
	SPEED_BOOST,
	LARGE_TONGUE,
	ROOTED
}
var skill_keys: Array = [
	"hard_skin",
	"healing_meal",
	"body_armor",
	"survivor",
	"energy_saver",
	"bloodthirsty",
	"speed_boost",
	"large_tongue",
	"rooted"
]
var skill_progression: Dictionary = {
	"hard_skin": "healing_meal",
	"healing_meal": "body_armor",
	"body_armor": "",
	"survivor": "energy_saver",
	"energy_saver": "bloodthirsty",
	"bloodthirsty": "",
	"speed_boost": "large_tongue",
	"large_tongue": "rooted",
	"rooted": ""
}



var SelectedButton = null
var selected_button_id: int = -1
var player_in_skill_tree_area: bool = false
var SkillButtons: Array = []


func _ready():
	self.visible = false
	# warning-ignore:return_value_discarded
	gui_events.connect("player_in_skill_tree_area", self, "_player_entered_area")
	# warning-ignore:return_value_discarded
	gui_events.connect("player_left_skill_tree_area", self, "_player_exited_area")
	# warning-ignore:return_value_discarded
	player_events.connect("player_interacted", self, "_on_player_interacted")
	SkillButtons = filter_texture_rect_nodes(SkillButtonGroup.get_children())
	BuyButton.visible = false
	update_points_label()
	check_skills()
	
	
func filter_texture_rect_nodes(NodeArray: Array):
	var result: Array = []
	for Obj in NodeArray:
		if not Obj is TextureRect: result.append(Obj)
	return result
	
	
func get_next_unlockable_skill(skill: String): return skill_progression[skill]
func get_skill_button(skill: String): return SkillButtons[skill_keys.find(skill)]
func check_skills():
	for skill in game_data.player_data.skills:
		if game_data.player_data.skills[skill]:
			var SkillButton = get_skill_button(skill)
			buy_skill(SkillButton)
			unlock_skill(get_next_unlockable_skill(skill))
			change_visual_path_color(skill)
			if skill_progression.has(skill): change_visual_path_color(skill_progression[skill], Color.white)
			
func update_points_label():
	var skill_points = get_skill_points()
	PointsLabel.text = tr(DEFAULT_POINTS_TEXT) % str(skill_points)
	PointsLabel.modulate = Color.red if skill_points <= 0 else Color.yellow
		
		

func get_skill_points() -> int: return game_data.get_player_data("skill_points")
func set_skill_points(value: int): 
	game_data.set_player_data("skill_points", value)
	global_data_manager.save_player_data()
	
func close_menu():
	self.visible = false
	game_data.can_pause = true
	player_events.emit_signal("unfreeze_player")
	emit_signal("exited_menu")
	# resets the menu
	SkillTitle.text = DEFAULT_TITLE
	SkillDescription.text = DEFAULT_DESCRIPTION
	if not is_instance_valid(SelectedButton): return
	SelectedButton.pressed = false
	SelectedButton = null
	BuyButton.visible = false
func open_menu():
	if self.visible: return
	
	self.visible = true
	game_data.can_pause= false
	player_events.emit_signal("freeze_player")
	emit_signal("opened_menu")
	# in case the player changes the language
	SkillTitle.text = DEFAULT_TITLE
	SkillDescription.text = DEFAULT_DESCRIPTION
	PointsLabel.text = tr(DEFAULT_POINTS_TEXT) % str(get_skill_points())
	
func get_skill_visual_path(skill: String): 
	if not skill in SkillPathTextureNodes: return null
	return SkillPathTextureNodes[skill]
func change_visual_path_color(skill: String, color: Color = Color.yellow):
	var chosen_skill = get_skill_visual_path(skill)
	if chosen_skill == null: return
	for texture in chosen_skill:
		get_node(texture).modulate = color
func buy_skill(TargetButton):
	TargetButton.modulate = Color.yellow
	
	

func _player_entered_area(): player_in_skill_tree_area = true
func _player_exited_area(): player_in_skill_tree_area = false
func _on_home_button_pressed(): close_menu()

func _on_player_interacted():
	if not player_in_skill_tree_area: return
	open_menu()


func _on_skin_button_toggled(id, btn_pressed):
	id = int(id)
	
	if is_instance_valid(SelectedButton) and SelectedButton.mouse_filter != MOUSE_FILTER_IGNORE: 
		SelectedButton.pressed = false
		SelectedButton.button_mask = BUTTON_MASK_LEFT
		
	if btn_pressed:
		selected_button_id = int(id)
		SkillTitle.text = tr("ui.skill_menu.title.%s" % skill_keys[id])
		SkillDescription.text = tr("ui.skill_menu.description.%s" % skill_keys[id])
		
	SelectedButton = SkillButtons[id]
	SelectedButton.button_mask = 0
	
	if SelectedButton.modulate == DISABLED_BUTTON_COLOR:
		BuyButton.visible = true
		disable_buy_button()
		return
	
	var skill_bought = game_data.get_player_data("skills")[skill_keys[id]]
	BuyButton.visible = !skill_bought
	BuyButton.modulate = Color.white if get_skill_points() > 0 else DARK_RED
	BuyButton.disabled = get_skill_points() <= 0
	
func disable_buy_button():
	BuyButton.modulate = DARK_RED
	BuyButton.disabled = true
	

func _on_buy_button_pressed():
	var chosen_skill = skill_keys[selected_button_id]
	
	if get_skill_button(chosen_skill).modulate == DISABLED_BUTTON_COLOR: return
	
	game_data.player_data.skills[chosen_skill] = true
	set_skill_points(get_skill_points() - 1)
	update_points_label()
	buy_skill(SelectedButton)
	
	var next_skill = get_next_unlockable_skill(chosen_skill)
	unlock_skill(next_skill)
	change_visual_path_color(chosen_skill)
	if skill_progression.has(chosen_skill): change_visual_path_color(skill_progression[chosen_skill], Color.white)
	
	BuyButton.visible = false
	
	
func unlock_skill(skill: String): 
	if skill.empty(): return
	get_skill_button(skill).modulate = Color.white
