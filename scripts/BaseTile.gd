extends Node3D

@export var can_be: Dictionary[String, PackedScene] = {}

@export var animation_player_path: NodePath = NodePath("AnimationPlayer")
@export var despawn_animation_name: String = ""
@export var animation_speed: float = 4
@onready var anim_player: AnimationPlayer = get_node(animation_player_path)

@onready var hover_anim_player: AnimationPlayer = $AnimationPlayerBaseTile

func _ready() -> void:
	SignalBus.connect("tile_select", _on_select)
	SignalBus.connect("tile_deselect", _on_deselect)
	SignalBus.connect("tile_change", _on_tile_change)
	
		# Connect animation finished signal
	if anim_player and not anim_player.is_connected("animation_finished", _on_animation_finished):
		anim_player.speed_scale = animation_speed
		anim_player.connect("animation_finished", _on_animation_finished)

	# Auto-play animation backward (spawn in)
	if despawn_animation_name != "" and anim_player.has_animation(despawn_animation_name):
		anim_player.play_backwards(despawn_animation_name)
	else:
		print("Missing or invalid despawn animation for", name)

func _on_tile_body_mouse_entered() -> void:
	if hover_anim_player and hover_anim_player.has_animation("BaseTileSelected"):
		hover_anim_player.play("BaseTileSelected")
	pass

func _on_tile_body_mouse_exited() -> void:
	if hover_anim_player and hover_anim_player.has_animation("BaseTileDeselected"):
		hover_anim_player.play("BaseTileDeselected")
	pass

func _on_tile_body_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		SignalBus.emit_signal("tile_select", self, can_be)

func _on_select(node: Node3D, _can_be: Dictionary[String, PackedScene]) -> void:
	if node == self:
		$Selected.visible = !$Selected.visible
	else:
		$Selected.visible = false

func _on_deselect() -> void:
	$Selected.visible = false

func _on_tile_change(scene: PackedScene) -> void:
	if $Selected.visible:
		var old_tile = self.owner
		var container = old_tile.owner
		var new_tile: Node3D = scene.instantiate()
		new_tile.position = old_tile.position
		container.remove_child(old_tile)
		container.add_child(new_tile)
		new_tile.owner = container
		old_tile.queue_free()
		SignalBus.emit_signal("tile_deselect")

#Call this externally to play despawn animation
func start_despawn():
	if despawn_animation_name != "" and anim_player.has_animation(despawn_animation_name):
		anim_player.speed_scale = animation_speed
		anim_player.play(despawn_animation_name)
	else:
		print("Cannot play despawn animation on", name)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == despawn_animation_name:
		SignalBus.emit_signal("tile_despawned", self)
