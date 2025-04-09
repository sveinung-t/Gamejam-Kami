extends LineEdit

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	self.text = str(rng.seed)
