extends Button
class_name EnhancedButton

@export var button_select_audio: AudioStreamPlayer
@export var button_pressed_audio: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_button_pressed)
	mouse_entered.connect(_on_mouse_entered)

func _on_button_pressed():
	button_pressed_audio.play()

func _on_mouse_entered() -> void:
	button_select_audio.play()
