extends Node3D

@export var can_be: Dictionary[String, PackedScene] = {}

@export var animation_player_path: NodePath = NodePath("AnimationPlayer")
@export var despawn_animation_name: String = ""
@onready var anim_player: AnimationPlayer = get_node(animation_player_path)

func _ready() -> void:
	SignalBus.connect("tile_select", onSelect)
	SignalBus.connect("tile_deselect", onDeselect)
	
		# Connect animation finished signal
	if anim_player and not anim_player.is_connected("animation_finished", _on_animation_finished):
		anim_player.connect("animation_finished", _on_animation_finished)

	# Auto-play animation backward (spawn in)
	if despawn_animation_name != "" and anim_player.has_animation(despawn_animation_name):
		anim_player.play_backwards(despawn_animation_name)
	else:
		print("Missing or invalid despawn animation for", name)

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

#Call this externally to play despawn animation
func start_despawn():
	if despawn_animation_name != "" and anim_player.has_animation(despawn_animation_name):
		anim_player.play(despawn_animation_name)
	else:
		print("Cannot play despawn animation on", name)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == despawn_animation_name:
		SignalBus.emit_signal("tile_despawned", self)
