extends Control

const GAME_SCENE_PATH := "res://game.tscn"
@onready var button_select_audio: AudioStreamPlayer = $ButtonSelect
@onready var button_pressed_audio: AudioStreamPlayer = $ButtonPressed
@onready var is_mobile = OS.has_feature('mobile') or OS.has_feature('web_android') or OS.has_feature('web_ios')

func _on_start_button_pressed():
	button_pressed_audio.play()
	LoadingScreen.load_scene(GAME_SCENE_PATH)


func _on_fullscreen_button_pressed():
	button_pressed_audio.play()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_audio_button_pressed() -> void:
	if AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")) > -80:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)

func _on_start_button_mouse_entered() -> void:
	button_select_audio.play()


func _on_quit_button_mouse_entered() -> void:
	button_select_audio.play()
