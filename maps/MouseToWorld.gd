extends Node3D

const RAY_LENGTH = 1000
var prevMouse: Vector2
var hoveredObj: CollisionObject3D

func _process(delta: float) -> void:
	getPosition()

func getPosition() -> void:
	var space = get_world_3d().direct_space_state
	var cam = get_viewport().get_camera_3d()
	var mouse: Vector2 = get_viewport().get_mouse_position()
	if (prevMouse == mouse): return
	prevMouse = mouse
	
	var origin = cam.project_ray_origin(mouse)
	var end = origin + cam.project_ray_normal(mouse) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var intersect = space.intersect_ray(query)
	var position = intersect.position
	var grid_pos = Vector3(roundDown(position.x),0, roundDown(position.z))
	
	if (intersect.is_empty()):
		hoveredObj = null
		print("Lost object")
		
	if(intersect.collider != hoveredObj):
		hoveredObj = intersect.collider
		print(hoveredObj)

func roundDown(n: float) -> float:
	var rounded = round(n)
	if(fposmod(rounded, 2) == 1): rounded = rounded-1
	return rounded
