extends Button

@onready var newgameMenu = $"../../../MainMenu"

func _ready() -> void:
	self.pressed.connect(toggleMenu)

func toggleMenu() -> void:
	newgameMenu.visible = !newgameMenu.visible
