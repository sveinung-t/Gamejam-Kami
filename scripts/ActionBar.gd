extends Node

func _ready() -> void:
	SignalBus.connect("tile_select", _on_tile_select)

func _on_tile_select(_node: Node3D, can_be: Dictionary[String, PackedScene]):
	var actionbar = get_node(".")
	var hotbar = get_node("Margins/Hotbar")
	
	actionbar.visible = false
	hotbar.get_children().all(func (x): 
		print(x)
		hotbar.remove_child(x)
	)
	
	can_be.keys().all(func (k: String):
		var newBtn = Button.new()
		
		var scene: PackedScene = can_be[k]
		newBtn.text = k
		hotbar.add_child(newBtn)
	)
	
	print(hotbar.get_children().size())
	if (hotbar.get_children().size()):
		actionbar.visible = true
