extends Control

@export var MAIN_MENU_SCENE_PATH: String = "res://Features/Menus/main_menu.tscn"
@onready var button_select_audio: AudioStreamPlayer = $ButtonSelect
@onready var button_pressed_audio: AudioStreamPlayer = $ButtonClick

func _on_exit_button_pressed() -> void:
	button_pressed_audio.play()
	LoadingScreen.load_scene(MAIN_MENU_SCENE_PATH)


func _on_exit_button_mouse_entered() -> void:
	button_select_audio.play()
