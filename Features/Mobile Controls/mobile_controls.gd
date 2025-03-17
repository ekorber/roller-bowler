extends Node2D
class_name MobileControls

@export var player: Player

@export var pause_menu: PauseMenu
@onready var pause_button: TouchScreenButton = $PauseButton

var paused_ui_showing: bool = false

@onready var left_button: TouchScreenButton = $LeftButton
@onready var right_button: TouchScreenButton = $RightButton
@onready var up_button: TouchScreenButton = $UpButton
@onready var down_button: TouchScreenButton = $DownButton
var left_input: float = 0.0
var right_input: float = 0.0
var up_input: float = 0.0
var down_input: float = 0.0

func _ready() -> void:
	if OS.has_feature('mobile') or OS.has_feature('web_android') or OS.has_feature('web_ios'):
		hide()
	else:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(up_input - down_input)
	if paused_ui_showing and not get_tree().paused:
		show_unpaused_ui()
	
	if not paused_ui_showing and get_tree().paused:
		show_paused_ui()
	
	player.turn_dir = right_input - left_input
	player.move_dir = up_input - down_input


func _on_pause_button_pressed() -> void:
	show_paused_ui()


func show_paused_ui():
	# Hide all buttons
	left_button.hide()
	right_button.hide()
	up_button.hide()
	down_button.hide()
	pause_button.hide()
	
	pause_menu.pause()
	paused_ui_showing = true


func show_unpaused_ui():
	# Show all buttons
	left_button.show()
	right_button.show()
	up_button.show()
	down_button.show()
	pause_button.show()
	
	paused_ui_showing = false


func _on_up_button_released() -> void:
	up_input = 0


func _on_down_button_released() -> void:
	down_input = 0


func _on_left_button_released() -> void:
	left_input = 0


func _on_right_button_released() -> void:
	right_input = 0


func _on_up_button_pressed() -> void:
	up_input = 1


func _on_down_button_pressed() -> void:
	down_input = 1


func _on_left_button_pressed() -> void:
	left_input = 1


func _on_right_button_pressed() -> void:
	right_input = 1
