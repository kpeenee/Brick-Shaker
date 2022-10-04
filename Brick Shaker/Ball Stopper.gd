extends Node

var wait_time = 0.5
var time_left 
var count = 3

onready var audio = $AudioStreamPlayer
var boop = preload("res://Assets/Sounds/wait blip.wav")
var go = preload("res://Assets/Sounds/go.wav")

signal ball_start
signal ball_stop

func _ready():
	time_left = wait_time
	
func _process(delta):
	if count <= 0:
		return
	time_left -= delta
	if time_left <= 0:
		count -= 1
		time_left = wait_time
		audio.stream = boop
		audio.play()
		if count <= 0:
			emit_signal("ball_start")
			audio.stream = go
			audio.play()

func _stop():
	emit_signal("ball_stop")
	count = 3


func _on_Ball_Death_Zone_body_entered(body):
	_stop()
