extends Node

func _ready() -> void:
	SignalBus.connect("tile_select", _on_tile_select)

func _on_tile_select(_node: Node3D, can_be: Array[PackedScene]):
	var actionbar = get_node(".")
	var hotbar = get_node("Margins/Hotbar")
	
	actionbar.visible = false
	hotbar.get_children().all(func (x): hotbar.remove_child(x))
	
	# todo: add buttons again
	
	if (hotbar.get_children().size):
		actionbar.visible
