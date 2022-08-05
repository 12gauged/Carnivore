extends Node2D

export(bool) var fire_lit = false

onready var AnimPlayer = $AnimationPlayer

func _process(_delta):
	AnimPlayer.play("on_fire" if fire_lit else "normal")
