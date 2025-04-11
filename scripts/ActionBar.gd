extends Node

const btnScript = preload("res://scripts/ActionBarBtn.gd")
@onready var actionbar: Control = %ActionBar
@onready var hotbar: Control = %Hotbar

func _ready() -> void:
	SignalBus.connect("tile_select", _on_tile_select)
	SignalBus.connect("tile_deselect", _on_tile_deselect)

func _on_tile_select(_node: Node3D, can_be: Dictionary[String, PackedScene]):
	reset_actionbar()
	
	var keys = can_be.keys()
	for k: String in keys:		
		var newBtn = Button.new()
		var scene: PackedScene = can_be[k]
		newBtn.text = k
		newBtn.set_script(btnScript)
		newBtn.scene = scene
		hotbar.add_child(newBtn)
	
	if (hotbar.get_children().size()):
		actionbar.visible = true

func _on_tile_deselect():
	reset_actionbar()

func reset_actionbar():
	for x: Control in hotbar.get_children():
		hotbar.remove_child(x)
	actionbar.visible = false
