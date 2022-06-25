extends VBoxContainer


const ARCHIEVEMENT_TITLE_BASE: String = "ui.archievements.%s.title"


onready var archievement_icons: Array = [
	$archievement_popup0,
	$archievement_popup1,
	$archievement_popup2
]


func _ready():
	var archievement_log = cache.get_from_cache("archievement_log")
	var current_archievement
	
	if archievement_log == null: return
	
	for archievement in archievement_log:
		current_archievement = archievement_icons[archievement_log.find(archievement)]
		current_archievement.visible = true
		current_archievement.set_text(tr(ARCHIEVEMENT_TITLE_BASE % archievement))
		current_archievement.animate()
		yield(get_tree().create_timer(0.8), "timeout")
	
	# resets the archievement log
	cache.add_to_cache("archievement_log", [])
	
