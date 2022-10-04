extends KinematicBody2D


var velocity = Vector2()
var speed = 400
var collision
var ball_pos
var start_pos
export var is_ball_moving = false
var collision_VFX = preload("res://Objects/Collision_VFX.tscn")
var death_VFX = preload("res://Objects/Death_VFX.tscn")
var collision_sound = preload("res://Assets/Sounds/Ball Collision.wav")
var brick_sound = preload("res://Assets/Sounds/Brick Collision.wav")
var ball_fall_sound = preload("res://Assets/Sounds/Ball Fall.wav")

onready var sound_player = $AudioStreamPlayer2D
export var shake_amount = 0.15

signal ball_move
signal ball_collide
signal camera_shake


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	velocity.x = rand_range(-1,1)
	velocity.y = -1
	velocity.normalized()
	start_pos = position
	
	

func _randomise_velocity():
	randomize()
	velocity.x = rand_range(-0.9,0.9)

# warning-ignore:unused_argument
func _process(delta):
	
	if (is_on_wall()):
		velocity.x = -velocity.x
	if (is_on_ceiling()||is_on_floor()):
		velocity.y = - velocity.y
	
	
	velocity.normalized()
# warning-ignore:return_value_discarded
	if is_ball_moving:
		move_and_slide(velocity * speed,Vector2.UP)
	
	emit_signal("ball_move", position)
	
	collision = get_last_slide_collision()
	
	if collision:
		var points = 5
		var effect = true
		sound_player.stream = collision_sound
		
		if collision.collider.is_in_group("Brick"):
			collision.collider.queue_free()
			points = 0
			emit_signal("camera_shake", shake_amount)
			effect = false
			sound_player.stream = brick_sound
			sound_player.play()
			_death_effect()
			
		if collision.collider.is_in_group("Paddle"):
			_randomise_velocity()
			points = 0
			
			
		emit_signal("ball_collide", points)
		sound_player.play()
		if (effect != false):
			_collision_effect()
			
		emit_signal("camera_shake", shake_amount)
		
func _collision_effect():
	var effect = collision_VFX.instance()
	get_parent().add_child(effect)
	effect.position = position
	effect.emitting = true
	
func _death_effect():
	var effect = death_VFX.instance()
	get_parent().add_child(effect)
	effect.position = position
	effect.emitting = true


func _on_DeathZone_body_entered(body):
	position = start_pos
	sound_player.stream = ball_fall_sound
	sound_player.play()
	_randomise_velocity()


func _on_Speed_Up_Timer_timeout():
	speed += 50
	print_debug("Ball speed is now: " + str(speed))


func _on_Ball_Stopper_ball_start():
	is_ball_moving = true


func _on_Ball_Stopper_ball_stop():
	is_ball_moving = false
