extends Area3D
class_name CheckpointArea3D

signal checkpoint_reached(location: Vector3)

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D):
	if body is Player:
		set_deferred("monitoring", false)
		checkpoint_reached.emit(global_position)
		anim.play("disappear")
