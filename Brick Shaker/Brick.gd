extends KinematicBody2D


export var move_speed = 10
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = Input.get_accelerometer().x * move_speed
	
	velocity = move_and_slide(velocity)
