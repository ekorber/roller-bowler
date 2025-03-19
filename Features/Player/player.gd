extends RigidBody3D
class_name Player

@export var level_geometry: Node3D
@export var level_pivot: Node3D
@export var rotation_sensitivity: float = 0.5
@onready var ground_penetration_raycast: RayCast3D = $GroundPenetrationRaycast
@onready var is_grounded_raycast: RayCast3D = $IsGroundedRaycast
@onready var camera: Camera3D = get_viewport().get_camera_3d()
@onready var original_player_pos = position
var can_control_player: bool = true
var rot_x: float = 0
var rot_y: float = 0
var push_x: float = 0
var push_z: float = 0
var max_push: float = 20

func _physics_process(delta: float) -> void:
	if not can_control_player:
		return
	
	# Rotate level geometry
	var camera_basis = camera.global_transform.basis
	level_pivot.position = position
	level_geometry.position = original_player_pos - position
	level_pivot.transform.basis = Basis()
	level_pivot.rotate(camera_basis.z, rot_x * rotation_sensitivity * 0.001)
	level_pivot.rotate(camera_basis.x, -rot_y * rotation_sensitivity * 0.001)
	
	# Apply additional force to ball when grounded
	is_grounded_raycast.global_position = global_position
	if is_grounded_raycast.is_colliding():
		push_x = clampf((rot_x * delta), -max_push, max_push)
		push_z = clampf((rot_y * delta), -max_push, max_push)
		# Create sharper reversals in direction
		if (push_x > 0 and linear_velocity.x < 0) or (push_x < 0 and linear_velocity.x > 0):
			push_x *= 2.0
		if (push_z > 0 and linear_velocity.z < 0) or (push_z < 0 and linear_velocity.z > 0):
			push_z *= 2.0
		apply_central_force(Vector3(push_x, 0, push_z))

	# Prevent ball from slipping through geometry
	ground_penetration_raycast.global_position = global_position
	if ground_penetration_raycast.is_colliding():
		global_position = ground_penetration_raycast.get_collision_point() + Vector3(0, 0.5, 0)


func _input(event: InputEvent) -> void:
	if can_control_player and event is InputEventMouseMotion:
		rot_x = clampf(rot_x + event.relative.x, -100, 100)
		rot_y = clampf(rot_y + event.relative.y, -100, 100)
