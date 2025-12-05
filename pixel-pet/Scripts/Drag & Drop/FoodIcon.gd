extends TextureRect
class_name FoodIcon

func _get_drag_data(_at_position: Vector2) -> Variant:
	# What data we send to the drop target
	var data := {
		"type": "food"
	}

	# Visual preview that follows the mouse
	var preview_tex := TextureRect.new()
	preview_tex.texture = texture
	preview_tex.size = size

	var preview_wrapper := Control.new()
	preview_wrapper.add_child(preview_tex)
	preview_tex.position = -preview_tex.size * 0.5

	set_drag_preview(preview_wrapper)
	return data
