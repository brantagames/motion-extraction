@tool
class_name MotionExtractionRect
extends TextureRect


const SHADER_PATH: String = "res://addons/motion_extraction/motion_extraction.gdshader"

@export var viewport: SubViewport:
	set(value):
		viewport = value
		update_configuration_warnings()
@export var frame_delay: int = 1:
	set(value):
		frame_delay = maxi(value, 1)

var _frame_buffer: Array[Image] = []
var _image_texture: ImageTexture


func _init() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	var shader_material := ShaderMaterial.new()
	shader_material.shader = load(SHADER_PATH)
	material = shader_material
	_image_texture = ImageTexture.new()
	texture = _image_texture


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	while _frame_buffer.size() > frame_delay - 1:
		_frame_buffer.pop_front()
	
	await RenderingServer.frame_pre_draw
	
	if frame_delay == 1:
		_image_texture.set_image(viewport.get_texture().get_image())
		return
	
	if _frame_buffer.size() == frame_delay - 1:
		_image_texture.set_image(_frame_buffer.pop_front())
	else:
		_image_texture.set_image(viewport.get_texture().get_image())
	_frame_buffer.append(viewport.get_texture().get_image())


func _get_configuration_warnings() -> PackedStringArray:
	if viewport:
		return []
	else:
		return ["This node does not have a viewport to get a texture from."]
