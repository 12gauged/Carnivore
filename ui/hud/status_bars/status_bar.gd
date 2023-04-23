extends Control


signal full


export(String, "hunger", "energy", "health", "shields") var id = ""
export(bool) var has_shader = false
export(Color) var full_color = Color.white
export(int) var critical = 0

onready var IconContainer = $icons
onready var Icons = IconContainer.get_children()
onready var IncreaseSoundEffect = $increase_sound_effect
onready var RedFlashAnimPlayer = $red_flash_anim_player

var last_value = 0


func _ready():
	player_events.connect("status_value_update", self, "_on_status_value_update")
	if has_shader: stop_shader()
	
	
	
func _on_status_value_update(stat_id, value, animate):
	if stat_id != id: return
	
	play_bar_animation(value)
	play_shader_anim(value)
	
	if animate: update_icons_with_animation(value)
	else: update_icons(value)
	
	if full(value): 
		emit_signal("full")
		self.modulate = full_color
	
	last_value = value if value != last_value else last_value	

	
	
	
	
func play_bar_animation(value):
	if full(value): return
	var anim = "flash_loop" if value <= critical else "RESET"
	RedFlashAnimPlayer.play(anim)
	
	
func update_icons(value):
	if value > last_value: increase_bar(value)
	else: decrease_bar(value)
	
func increase_bar(value):
	for i in range(value):
		Icons[i].show()

func decrease_bar(value):
	if value >= len(Icons): return
	for i in range(value):
		if i < value: continue
		Icons[i].hide()
	
	
	
func update_icons_with_animation(value):
	if value > last_value: increase_bar_animated(value)
	else: decrease_bar_animated(value)
	
func increase_bar_animated(value):
	IncreaseSoundEffect.play()
	for i in range(value):
		Icons[i].play_fill_anim()
		
func decrease_bar_animated(value):
	if value >= len(Icons): return	
	for i in range(6):
		if i < value: continue
		if not Icons[i].visible: continue
		Icons[i].play_empty_anim()
	
	
	
	
func play_shader_anim(value):
	if not has_shader: return
	if full(value):
		init_shader()
		return
	stop_shader()
	

func init_shader():
	for Icon in Icons:
		Icon.material.set_shader_param("active", true)
func stop_shader():
	for Icon in Icons:
		Icon.material.set_shader_param("active", false)
	
	
	
func full(value): return value == len(Icons)
		
		
		
		
