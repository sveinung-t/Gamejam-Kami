extends Node

@warning_ignore("unused_signal")
signal tile_select(node: Node3D, can_be: Dictionary[String, PackedScene])
@warning_ignore("unused_signal")
signal tile_deselect()
@warning_ignore("unused_signal")
signal close_main_menu()
@warning_ignore("unused_signal")
signal toggle_main_menu()

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			SignalBus.emit_signal("tile_deselect")
			SignalBus.emit_signal("close_main_menu")
