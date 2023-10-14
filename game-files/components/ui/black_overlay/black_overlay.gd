extends CanvasLayer


signal faded_in
signal faded_out
signal fading_in
signal fading_out
@onready var color_rect: ColorRect = $ColorRect
const color_alpha: Color = Color(0.0, 0.0, 0.0, 0.0)


var tweens: Dictionary = {}


func _ready() -> void:
	hide_black_overlay()
	Game.show_black_overlay_request.connect(show_black_overlay)
	Game.hide_black_overlay_request.connect(hide_black_overlay)
	
	
func show_black_overlay(mode: String) -> void:
	match mode:
		"fade_in":
			fade_in()
		"fade_out":
			fade_out()
			
	
	
func hide_black_overlay() -> void:
	color_rect.set_color(color_alpha)
	
	
func fade_in() -> void:
	var tween: Tween = self.create_tween()
	tween.finished.connect(on_tween_finished)
	
	tween.tween_property(color_rect, "color", Color.BLACK, 1.0).from_current()
	fading_in.emit()
	UIEvents.black_overlay_fading_in.emit()
	

func fade_out() -> void:
	var tween: Tween = self.create_tween()
	tween.finished.connect(on_tween_finished)
	
	tween.tween_property(color_rect, "color", color_alpha, 1.0).from(Color.BLACK)
	fading_out.emit()
	UIEvents.black_overlay_fading_out.emit()


func on_tween_finished() -> void:
	match color_rect.get_color():
		Color.BLACK:
			faded_in.emit()
			UIEvents.black_overlay_faded_in.emit()
		color_alpha:
			faded_out.emit()
			UIEvents.black_overlay_faded_out.emit()
