extends Node3D

func _on_static_body_3d_mouse_entered() -> void:
	print("true")
	$Selected.visible = true

func _on_static_body_3d_mouse_exited() -> void:
	print("false")
	$Selected.visible = false

func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	print(camera, event, event_position)
