extends TextureRect
class_name WaterIcon

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data := {"type": "water"}
	var preview := TextureRect.new()
	preview.texture = texture
	preview.size = size
	var wrapper := Control.new()
	wrapper.add_child(preview)
	preview.position = -preview.size * 0.5
	set_drag_preview(wrapper)
	return data
