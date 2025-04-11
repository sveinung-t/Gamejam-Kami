extends Node

const btnScript = preload("res://scripts/ActionBarBtn.gd")

func _ready() -> void:
	SignalBus.connect("tile_select", _on_tile_select)
	SignalBus.connect("tile_deselect", _on_tile_deselect)

func _on_tile_select(_node: Node3D, can_be: Dictionary[String, PackedScene]):
	var actionbar = get_node(".")
	var hotbar = get_node("Margins/Hotbar")
	
	actionbar.visible = false
	hotbar.get_children().all(func (x): 
		print(x)
		hotbar.remove_child(x)
	)
	
	var keys = can_be.keys()
	for k: String in keys:
		print(k)
		
		var newBtn = Button.new()
		var scene: PackedScene = can_be[k]
		newBtn.text = k
		newBtn.set_script(btnScript)
		newBtn.scene = scene
		hotbar.add_child(newBtn)
	
	if (hotbar.get_children().size()):
		actionbar.visible = true

func _on_tile_deselect():
	var actionbar = get_node(".")
	var hotbar = get_node("Margins/Hotbar")
	
	hotbar.get_children().all(func (x): 
		print(x)
		hotbar.remove_child(x)
	)
	actionbar.visible = false
