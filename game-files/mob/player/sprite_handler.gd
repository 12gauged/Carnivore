extends Sprite2D


@export var Hands: Sprite2D
@export var HandsHolding: Sprite2D
@export var HeldItem: Sprite2D


func _ready() -> void:
	Hands.show()
	HandsHolding.hide()


func set_held_item(data: Resource) -> void:
	HeldItem.set_texture(data.on_hand_sprite)


func hands_holding_projectile(data: Resource) -> void:
	Hands.hide()
	HandsHolding.show()
	set_held_item(data)


func projectile_used():
	Hands.show()
	HandsHolding.hide()
