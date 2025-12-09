extends CanvasLayer

@onready var icon: Sprite2D = $Icon

@export var cursor_scale := 2.0
@export var cursor_offset := Vector2(12, 12)

func _ready():
	hide()

func show_item(texture: Texture2D) -> void:
	icon.texture = texture
	icon.scale = Vector2.ONE * cursor_scale
	show()

func clear() -> void:
	hide()
	icon.texture = null

func _process(_delta):
	if visible:
		icon.global_position = get_viewport().get_mouse_position() + cursor_offset
