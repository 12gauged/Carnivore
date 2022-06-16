extends TextureRect

const GRAY: Color = Color(0.25, 0.25, 0.25, 1.0)
const WHITE: Color = Color.white
const YELLOW: Color = Color.yellow

onready var Title: Label = $title
onready var Description: Label = $description
onready var StarIcon: TextureRect = $star_icon_container/star_icon

func set_archievement(title, description):
	Title.text = title
	Description.text = description
	
func mark_archievement_as_complete():
	Title.modulate = GRAY
	Description.modulate = GRAY
	StarIcon.visible = true

func mark_archievement_as_incomplete():
	Title.modulate = YELLOW
	Description.modulate = WHITE
	StarIcon.visible = false
