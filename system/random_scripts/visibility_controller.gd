extends CanvasItem

export(bool) var visible_by_default = true

func _ready(): self.visible = visible_by_default

func show(): visible = true
func hide(): visible = false
