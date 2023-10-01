extends Sprite2D


@export_category("Sprites")
@export var hands: Sprite2D
@export var hands_holding: Sprite2D
@export var held_item: Sprite2D

@export_category("Animation")
@export var animation_player: AnimationPlayer
@export var animation_tree: AnimationTree


func _ready() -> void:
	hands.show()
	hands_holding.hide()


func set_held_item(data: Resource) -> void:
	held_item.set_texture(data.on_hand_sprite)


func hands_holding_projectile(data: Resource) -> void:
	hands.hide()
	hands_holding.show()
	set_held_item(data)


func projectile_used() -> void:
	hands.show()
	hands_holding.hide()


func _on_keyboard_motion_handler_direction_vector_updated(direction: Vector2) -> void:
	var animation_tree_playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
	if direction == Vector2.ZERO:
		animation_tree_playback.travel("idle")
		return
	animation_tree_playback.travel("walk")
		
