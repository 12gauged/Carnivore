extends Control

signal opened_menu
signal exited_menu


const DEFAULT_POINTS_TEXT = "points: %s"
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
	"bloodthirst": [],
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
	BLOODTHIRST,
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
	"bloodthirst",
	"speed_boost",
	"large_tongue",
	"rooted"
]
var skill_progression: Dictionary = {
	"hard_skin": "healing_meal",
	"healing_meal": "body_armor",
	"body_armor": "",
	"survivor": "energy_saver",
	"energy_saver": "bloodthirst",
	"bloodthirst": "",
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
	gui_events.connect("player_in_skill_tree_area", self, "_player_entered_area")
	gui_events.connect("player_left_skill_tree_area", self, "_player_exited_area")
	player_events.connect("player_interacted_mobile", self, "_on_player_interacted_mobile")
	SkillButtons = SkillButtonGroup.get_children()
	BuyButton.visible = false
	update_points_label()
	check_skills()
	
func _input(event):
	if not player_in_skill_tree_area: return
	if not event is InputEventKey: return
	if not event.is_action_pressed("controls_interact"): return
	open_menu()
	
	
	
func get_next_unlockable_skill(skill: String): return skill_progression[skill]
func get_skill_button(skill: String): return SkillButtons[skill_keys.find(skill)]
func unlock_skill(skill: String): 
	if skill.empty(): return
	get_skill_button(skill).enable()
func check_skills():
	for skill in game_data.player_data.skills:
		if game_data.player_data.skills[skill]:
			var SkillButton = get_skill_button(skill)
			buy_skill(SkillButton)
			unlock_skill(get_next_unlockable_skill(skill))
			
func update_points_label():
	var skill_points = get_skill_points()
	PointsLabel.text = DEFAULT_POINTS_TEXT % str(skill_points)
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
func open_menu():
	self.visible = true
	game_data.can_pause= false
	player_events.emit_signal("freeze_player")
	emit_signal("opened_menu")
	
func buy_skill(TargetButton):
	TargetButton.modulate = Color.yellow
	
	

func _player_entered_area(): player_in_skill_tree_area = true
func _player_exited_area(): player_in_skill_tree_area = false
func _on_home_button_pressed(): close_menu()

func _on_player_interacted_mobile():
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
	
	var skill_bought = game_data.get_player_data("skills")[skill_keys[id]]
	BuyButton.visible = !skill_bought
	BuyButton.modulate = Color.white if get_skill_points() > 0 else DARK_RED
	BuyButton.disabled = get_skill_points() <= 0
	

func _on_buy_button_pressed():
	var chosen_skill = skill_keys[selected_button_id]
	game_data.player_data.skills[chosen_skill] = true
	set_skill_points(get_skill_points() - 1)
	update_points_label()
	buy_skill(SelectedButton)
	unlock_skill(get_next_unlockable_skill(chosen_skill))
	BuyButton.visible = false
	
	
	print("skill_tree_menu.gd: buying: %s" % chosen_skill)
