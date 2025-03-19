extends AudioStreamPlayer
class_name SoundtrackPlayer

@export var song_list: Array[AudioStream]
var last_index: int = -1

func _ready() -> void:
	finished.connect(play_random)
	if song_list.size() > 0:
		play_random()

func play_random():
	var index = randi_range(0, song_list.size() - 1)
	
	while index == last_index:
		index = randi_range(0, song_list.size() - 1)
	
	stream = song_list[index]
	last_index = index
	
	play()
