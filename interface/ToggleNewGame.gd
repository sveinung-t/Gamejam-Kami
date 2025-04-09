extends Button

@onready var newgameMenu = $"../../../NewGame"

func _ready() -> void:
	self.pressed.connect(toggleMenu)

func toggleMenu() -> void:
	newgameMenu.visible = !newgameMenu.visible
