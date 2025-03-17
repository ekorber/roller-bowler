extends Control

@onready var start_button: Button = $Panel/StartButton
@onready var button_select_audio: AudioStreamPlayer = $ButtonSelect
@onready var button_pressed_audio: AudioStreamPlayer = $ButtonClick

func _on_start_button_pressed() -> void:
	start_button.disabled = true
	button_pressed_audio.play()
	get_tree().current_scene.begin_play()


func _on_start_button_mouse_entered() -> void:
	button_select_audio.play()
