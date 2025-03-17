extends CanvasLayer

var target_scene_path: String = ""

var can_load: bool = false
var loading_status : int
var progress : Array[float]

@onready var progress_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	hide()

func load_scene(path: String):
	get_tree().paused = true
	progress_bar.value = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	target_scene_path = path
	ResourceLoader.load_threaded_request(target_scene_path)
	can_load = true
	show()

func on_loading_complete():
	can_load = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = false
	hide()

func _process(_delta: float) -> void:
	# Don't load anything until allowed to do so
	if not can_load:
		return
	
	# Update the status:
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene:
			var scene: PackedScene = ResourceLoader.load_threaded_get(target_scene_path)
			get_tree().change_scene_to_packed(scene)
			on_loading_complete()
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happend:
			print("Error. Could not load Resource")
			on_loading_complete()
