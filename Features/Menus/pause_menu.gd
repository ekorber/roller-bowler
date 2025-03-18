extends Control
class_name PauseMenu

signal paused
signal unpaused

@export var MAIN_MENU_SCENE_PATH: String = "res://Features/Menus/main_menu.tscn"
@onready var button_select_audio: AudioStreamPlayer = $ButtonSelect
@onready var button_pressed_audio: AudioStreamPlayer = $ButtonPressed
@onready var is_mobile = OS.has_feature('mobile') or OS.has_feature('web_android') or OS.has_feature('web_ios')
var can_pause: bool = true

func _ready() -> void:
	hide()

func pause():
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused.emit()

func unpause():
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	unpaused.emit()


func _process(_delta: float) -> void:
	if can_pause and Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func _on_resume_button_pressed():
	button_pressed_audio.play()
	unpause()


func _on_quit_button_pressed():
	LoadingScreen.load_scene(MAIN_MENU_SCENE_PATH)


func _on_fullscreen_button_pressed() -> void:
	button_pressed_audio.play()
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_mouse_entered() -> void:
	button_select_audio.play()


func _on_audio_button_pressed() -> void:
	if AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")) > -80:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)
