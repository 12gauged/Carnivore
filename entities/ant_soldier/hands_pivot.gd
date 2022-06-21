extends Component

onready var texture: Sprite = $hands_holding_spear_overlay

func _execute(_delta):
	texture.flip_h = Owner.AI_TARGET.global_position.x < global_position.x
