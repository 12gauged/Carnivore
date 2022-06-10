extends GridContainer


onready var Confetti: CPUParticles2D = $star_icon/confetti
onready var Nodes: Array = [
	$star_icon,
	$lowest_time
]


func _on_time_best_time_reached():
	return # TEMP
	
	for CurrentNode in Nodes:
		CurrentNode.modulate = Color.yellow
	Confetti.emitting = true
