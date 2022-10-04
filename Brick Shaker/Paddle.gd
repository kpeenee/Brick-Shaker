extends KinematicBody2D

var ball_location
var speed = 8

func _process(delta):
	position.x = move_toward(position.x,ball_location.x,speed)
	



func _on_ball_move(ball_pos):
	ball_location = ball_pos


func _on_Speed_Up_Timer_timeout():
	speed += 2
	print_debug("speed is now: " + str(speed))
