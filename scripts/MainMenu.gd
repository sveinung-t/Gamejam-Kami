extends Control

@onready var mainMenuRoot = $"."
@onready var seedEntry = $MainMenu/MarginContainer/VBoxContainer/Seed
@onready var randomizeBtn = $MainMenu/MarginContainer/VBoxContainer/Randomize
@onready var newgameBtn = $MainMenu/MarginContainer/VBoxContainer/Newgame
@onready var exitBtn = $MainMenu/MarginContainer/VBoxContainer/Exit
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	setNewSeed()
	randomizeBtn.pressed.connect(setNewSeed)
	newgameBtn.pressed.connect(newGame)
	exitBtn.pressed.connect(exitGame)
	
func setNewSeed() -> void:
	rng.randomize()
	seedEntry.text = str(rng.seed)

func newGame() -> void:
	var seed: String = seedEntry.text
	rng.seed = seed.hash()
	
	print(rng.seed)

func exitGame() -> void:
	get_tree().quit()

func _on_overlay_gui_input(event: InputEvent) -> void:
	mainMenuRoot.visible = false
