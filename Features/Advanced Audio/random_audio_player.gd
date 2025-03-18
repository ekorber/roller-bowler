extends AudioStreamPlayer
class_name RandomAudioStreamPlayer

@export var audio_clips: Array[AudioStream]
var last_index: int = -1

func play_random():
	var index = randi_range(0, audio_clips.size() - 1)
	
	while index == last_index:
		index = randi_range(0, audio_clips.size() - 1)
	
	stream = audio_clips[index]
	last_index = index
	
	play()
