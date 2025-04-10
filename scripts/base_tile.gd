extends Node3D

func _on_static_body_3d_mouse_entered() -> void:
	$Selected.visible = true

func _on_static_body_3d_mouse_exited() -> void:
	$Selected.visible = false
