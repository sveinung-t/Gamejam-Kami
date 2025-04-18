extends Control

@onready var overlay = $"../Overlay"
@onready var seedEntry = $MarginContainer/VBoxContainer/Seed
@onready var randomizeBtn = $MarginContainer/VBoxContainer/Randomize
@onready var newgameBtn = $MarginContainer/VBoxContainer/Newgame
@onready var exitBtn = $MarginContainer/VBoxContainer/Exit

func _ready() -> void:
	randomizeBtn.pressed.connect(setNewSeed)
	newgameBtn.pressed.connect(newGame)
	exitBtn.pressed.connect(exitGame)
	setNewSeed()
	SignalBus.connect("close_main_menu", _on_close_menu)
	SignalBus.connect("toggle_main_menu", _on_toggle_menu)
	
func setNewSeed() -> void:
	
	RngContext.c.randomize()
	seedEntry.text = str(RngContext.c.seed)

func newGame() -> void:
	var seedText: String = seedEntry.text
	RngContext.c.seed = seedText.hash()
	get_tree().reload_current_scene()

func exitGame() -> void:
	get_tree().quit()

func _on_close_menu() -> void:
	self.visible = false
	overlay.visible = false

func _on_toggle_menu() -> void:
	self.visible = !self.visible
	overlay.visible = !overlay.visible

func _on_overlay_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		SignalBus.emit_signal("close_main_menu")
