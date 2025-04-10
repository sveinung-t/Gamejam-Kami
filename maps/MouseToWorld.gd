extends Node3D

const RAY_LENGTH = 1000
var prevMouse: Vector2

func _process(delta: float) -> void:
	var space = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mouse: Vector2 = get_viewport().get_mouse_position()
	if (prevMouse == mouse): return
	prevMouse = mouse
	
	var origin = cam.project_ray_origin(mouse)
	var end = origin + cam.project_ray_normal(mouse) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var intersect = space.intersect_ray(query).position
	var grid_pos = Vector3(roundDown(intersect.x),0, roundDown(intersect.z))
	
	print(grid_pos)

func roundDown(n: float) -> float:
	var rounded = round(n)
	if(fposmod(rounded, 2) == 1): rounded = rounded-1
	return rounded
