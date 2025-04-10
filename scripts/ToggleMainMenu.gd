extends Button

@onready var newgameMenu = $"../../../MainMenu"

func _ready() -> void:
	self.pressed.connect(toggleMenu)

func toggleMenu() -> void:
	SignalBus.emit_signal("toggle_main_menu")
