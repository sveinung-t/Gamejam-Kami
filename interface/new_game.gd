extends PanelContainer

@onready var seedEntry = $MarginContainer/VBoxContainer/Seed
@onready var randomizeBtn = $MarginContainer/VBoxContainer/Randomize
@onready var newgameBtn = $MarginContainer/VBoxContainer/Newgame
@onready var exitBtn = $MarginContainer/VBoxContainer/Exit
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	setNewSeed()
	randomizeBtn.pressed.connect(setNewSeed)
	newgameBtn.pressed.connect(newGame)
	
func setNewSeed() -> void:
	rng.randomize()
	seedEntry.text = str(rng.seed)

func newGame() -> void:
	var seed: String = seedEntry.text
	rng.seed = seed.hash()
	
	print(rng.seed)
