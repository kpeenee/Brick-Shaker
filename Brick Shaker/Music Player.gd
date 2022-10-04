extends AudioStreamPlayer

var music_playlist = [preload("res://Assets/Music/Test Song.wav"), 
preload ("res://Assets/Music/Boop Boop Ba Dup.wav")]

var track_number

func _ready():
	track_number = round(rand_range(0,music_playlist.size() - 1))
	stream = music_playlist[track_number]


func _on_Music_Player_finished():
	_ready()
	stream = music_playlist[track_number]
	play()

