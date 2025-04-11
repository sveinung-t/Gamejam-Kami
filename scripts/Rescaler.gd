extends Node

@export var scaleVariance = 0.1
@export var angleVariance = 60
@onready var rng = RngContext.c

func _ready() -> void:
	self.rotation += Vector3(0, RngContext.c.randf_range(0.0, angleVariance), 0)
	self.scale *= RngContext.c.randf_range(1-scaleVariance, 1+scaleVariance)
