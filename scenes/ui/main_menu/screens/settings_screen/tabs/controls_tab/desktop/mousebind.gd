extends HBoxContainer

signal request_key_assignment(action, requester, type)
signal button_released

export(String, "controls_shoot", "controls_special") var assigned_action = ""
onready var AnimPlayer := $AnimationPlayer
onready var Btn := $button_medium
onready var BtnTexture := $button_medium/button_texture
onready var button_id = game_data.game_settings.desktop_keybinds[assigned_action]

var mouse_textures: Dictionary

func _ready():
	mouse_textures = resources.get_resource("sprites", "mouse_textures")
	if button_id == null: return
	set_texture(button_id)


func _on_button_medium_button_pressed(_id):
	emit_signal("request_key_assignment", assigned_action, self, "mouse")
	

func start_flashing(): 
	set_texture(0)
	AnimPlayer.play("key_label_flash")
func stop_flashing(): AnimPlayer.play("RESET")

func set_texture(btn_id: int): 
	if not btn_id in mouse_textures.keys(): return
	BtnTexture.texture = mouse_textures[btn_id]
func disable(): Btn.disable()
func enable(): Btn.enable()


func _on_button_released(): emit_signal("button_released")
