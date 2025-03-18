extends RigidBody3D
class_name Player

@export var level_geometry: Node3D
@export var rotation_sensitivity: float = 0.5
@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var original_pos = level_geometry.global_position
var can_control_player: bool = true
var rot_x: float = 0
var rot_y: float = 0

func _physics_process(_delta: float) -> void:
	# Get the camera's orientation
	var camera_basis = camera.global_transform.basis
	level_geometry.transform.basis = Basis()
	rotate_around_point(camera_basis.z, rot_x * rotation_sensitivity * 0.001)
	rotate_around_point(camera_basis.x, rot_y * rotation_sensitivity * 0.001)

func _input(event: InputEvent) -> void:
	if can_control_player and event is InputEventMouseMotion:
		rot_x += event.relative.x
		rot_y += event.relative.y

func rotate_around_point(axis, angle):
	level_geometry.global_position = global_position + (original_pos - global_position).rotated(axis, angle)
	level_geometry.rotate(axis, angle)
