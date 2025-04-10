extends Node

func _ready() -> void:
	SignalBus.connect("tile_select", _on_tile_select)

func _on_tile_select(_node: Node3D, can_be: Array[PackedScene]):
	var actionbar = get_node(".")
	var hotbar = get_node("Margins/Hotbar")
	
	actionbar.visible = false
	hotbar.get_children().all(func (x): 
		print(x)
		hotbar.remove_child(x)
	)
	
	can_be.all(func (k: PackedScene):
		print(k)
		var newBtn = Button.new()
		
		newBtn.text = k.resource_path.get_file().trim_suffix('.tscn')
		hotbar.add_child(newBtn)
	)
	
	print(hotbar.get_children().size())
	if (hotbar.get_children().size()):
		actionbar.visible = true
