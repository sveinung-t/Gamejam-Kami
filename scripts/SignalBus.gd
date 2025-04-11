extends Node

@warning_ignore_start("unused_signal")
signal tile_select(node: Node3D, can_be: Dictionary[String, PackedScene])
signal tile_deselect()
signal tile_change(scene: PackedScene)
signal tile_despawned()
signal close_main_menu()
signal toggle_main_menu()
@warning_ignore_restore("unused_signal")

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			SignalBus.emit_signal("tile_deselect")
			SignalBus.emit_signal("close_main_menu")
