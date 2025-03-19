extends Area3D
class_name PlayerOrientedArea3D

signal player_entered

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if body is Player:
		player_entered.emit()
