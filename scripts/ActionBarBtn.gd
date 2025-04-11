extends Button

@export var scene: PackedScene

func _pressed() -> void:
	SignalBus.emit_signal("tile_change", scene)
