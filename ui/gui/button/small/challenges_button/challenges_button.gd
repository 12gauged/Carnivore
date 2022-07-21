extends GenericButtonIcon
func _ready():
	self.disabled = game_data.get_player_data("generation") < 0
	# warning-ignore:return_value_discarded
	if !is_instance_valid(Child): return
	if self.disabled: Child.modulate = GRAY
