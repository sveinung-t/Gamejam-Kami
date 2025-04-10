extends Node3D

func _ready() -> void:
	self.connect("tile_select", onSelect)
	print("Connected?")

func _on_tile_body_mouse_entered() -> void:
	self.position.y = 0.1

func _on_tile_body_mouse_exited() -> void:
	self.position.y = 0.0

func _on_tile_body_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		self.emit_signal("tile_select", self)

func onSelect(node: Node3D) -> void:
	print("Woo!")
	if node == self:
		$Selected.visible = true
	else:
		$Selected.visible = false
