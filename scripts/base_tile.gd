extends Node3D

@export var can_be: Dictionary[String, PackedScene] = {}

func _ready() -> void:
	SignalBus.connect("tile_select", onSelect)
	SignalBus.connect("tile_deselect", onDeselect)

func _on_tile_body_mouse_entered() -> void:
	self.position.y = 0.1

func _on_tile_body_mouse_exited() -> void:
	self.position.y = 0.0

func _on_tile_body_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(can_be)
		SignalBus.emit_signal("tile_select", self, can_be)

func onSelect(node: Node3D, _can_be: Dictionary[String, PackedScene]) -> void:
	if node == self:
		$Selected.visible = !$Selected.visible
	else:
		$Selected.visible = false

func onDeselect() -> void:
	$Selected.visible = false
