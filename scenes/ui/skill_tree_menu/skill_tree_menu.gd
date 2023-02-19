extends Control

signal opened_menu
signal exited_menu


export(NodePath) var SkillButtonGroupPath
onready var SkillButtonGroup = get_node(SkillButtonGroupPath)

export(NodePath) var BuyButtonPath
onready var BuyButton = get_node(BuyButtonPath)


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
	check_skills()
	
func _input(event):
	if not player_in_skill_tree_area: return
	if not event is InputEventKey: return
	if not event.is_action_pressed("controls_interact"): return
	open_menu()
	
	
	
func check_skills():
	for skill in game_data.player_data.skills:
		if game_data.player_data.skills[skill]:
			button_skill_bought(SkillButtons[skill_keys.find(skill)])
	
	
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
	
	
func button_skill_bought(TargetButton):
	TargetButton.modulate = Color.yellow
	TargetButton.mouse_filter = MOUSE_FILTER_IGNORE
	TargetButton.pressed = false
	
	

func _player_entered_area(): player_in_skill_tree_area = true
func _player_exited_area(): player_in_skill_tree_area = false
func _on_home_button_pressed(): close_menu()



func _on_player_interacted_mobile():
	if not player_in_skill_tree_area: return
	open_menu()


func _on_skin_button_toggled(id, btn_pressed):
	if is_instance_valid(SelectedButton) and SelectedButton.mouse_filter != MOUSE_FILTER_IGNORE: 
		SelectedButton.pressed = false
		SelectedButton.button_mask = BUTTON_MASK_LEFT
		
	if btn_pressed:
		selected_button_id = int(id)
		print("skill_tree_menu.gd: id: %s\nbtn_pressed: %s\n" % [id, btn_pressed])
		
	SelectedButton = SkillButtons[int(id)]
	SelectedButton.button_mask = 0
	BuyButton.visible = true
	

func _on_buy_button_pressed():
	var chosen_skill = skill_keys[selected_button_id]
	game_data.player_data.skills[chosen_skill] = true
	button_skill_bought(SelectedButton)
	
	
	print("skill_tree_menu.gd: buying: %s" % chosen_skill)
