extends CanvasLayer
## Global script: Simple fade in/out script used by global ScreenManager and any other Screens that need it.
## TODO: Update to better, fancier transition.


var _tween: Tween
var _is_faded_out: bool = false
var _is_busy: bool = false


@onready var rect: ColorRect = ColorRect.new()


func _ready() -> void:
	layer = 100
	add_child(rect)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.color = Color(0,0,0,0) # Black, transparent
	rect.size = get_viewport().get_visible_rect().size


func fade_out(d: float = 0.3) -> void:
	if _is_faded_out or _is_busy:
		return
	_is_busy = true

	if _tween and _tween.is_running():
		_tween.kill()

	_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(rect, "color", Color.BLACK, d)
	# The `await` makes this a coroutine, meaning that the fade_out function can also be await-ed
	await _tween.finished

	_is_faded_out = true
	_is_busy = false


func fade_in(d: float = 0.3) -> void:
	if not _is_faded_out or _is_busy:
		return
	_is_busy = true

	if _tween and _tween.is_running():
		_tween.kill()

	_tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	_tween.tween_property(rect, "color", Color(0,0,0,0), d)
	# The `await` makes this a coroutine, meaning that the fade_in function can also be await-ed
	await _tween.finished

	_is_faded_out = false
	_is_busy = false
