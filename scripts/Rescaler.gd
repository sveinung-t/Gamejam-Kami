extends Node

@export var scaleVariance = 0.5
@export var maxScale = 1.5
@export var angleVariance = 0.3
@onready var rng = RngContext.c

func _ready() -> void:
	#self.rotation *= Vector3(0, RngContext.c.randf_range(0-angleVariance, 0+angleVariance), 0)
	self.scale *= RngContext.c.randf_range(1-scaleVariance, 1+scaleVariance)
