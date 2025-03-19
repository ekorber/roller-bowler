extends Node
class_name GameManager

signal on_game_over

@onready var time_label: Label = $HUD/TimeLabel
@export var time_remaining: float

@onready var player: Player = $Player
@onready var intro_screen_anim: AnimationPlayer = $IntroScreen/AnimationPlayer
@onready var game_over_screen_anim: AnimationPlayer = $GameOverScreen/AnimationPlayer
@onready var game_over_message_label: Label = $GameOverScreen/Panel/Message
@onready var pause_menu: PauseMenu = $PauseMenu
@onready var hud: Control = $HUD
@onready var hud_anim: AnimationPlayer = $HUD/AnimationPlayer
@onready var respawn_location: Vector3 = player.global_position

const MAIN_MENU_SCENE_PATH := "res://Features/Menus/main_menu.tscn"
var game_playing: bool = false

func _ready() -> void:
	player.can_control_player = false
	pause_menu.can_pause = false
	hud.hide()
	intro_screen_anim.play('open_popup')
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func begin_play():
	intro_screen_anim.play_backwards('open_popup')
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	for child in get_children():
		if child is MobileControls:
			child.show()
	
	player.can_control_player = true
	pause_menu.can_pause = true
	game_playing = true
	
	hud.show()

func _process(delta: float) -> void:
	if not game_playing:
		return
	
	time_label.text = '%d' % (time_remaining + 1)
	
	if time_remaining <= 15.0:
		time_label.label_settings.font_color = Color.RED
	else:
		time_label.label_settings.font_color = Color.WHITE_SMOKE
	
	time_remaining -= delta
	if time_remaining <= 0:
		game_over()

func game_over():
	game_playing = false
	pause_menu.can_pause = false
	player.can_control_player = false
	hud.hide()
	
	for child in get_children():
		if child is MobileControls:
			child.hide()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	game_over_message_label.text = 'Oops! Better luck next time!'
	game_over_screen_anim.play('open_popup')
	
	on_game_over.emit()

func on_checkpoint_reached(new_respawn_location: Vector3):
	respawn_location = new_respawn_location

func respawn_at_checkpoint():
	player.global_position = respawn_location
	player.linear_velocity = Vector3.ZERO
	player.angular_velocity = Vector3.ZERO
	player.rot_x = 0
	player.rot_y = 0
