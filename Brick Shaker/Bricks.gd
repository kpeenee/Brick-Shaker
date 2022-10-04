extends Node2D

var score = 0
signal points_changed
signal game_over

func _add_score(scoretoadd):
	score += scoretoadd
	emit_signal("points_changed",score)
	
func _process(delta):
	if get_child_count() <= 1 :
		emit_signal("game_over",score)

func _on_Timer_timeout():
	_add_score(20)


func _on_ball_collide(points):
	_add_score(points)


func _on_Ball_Death_Zone_body_entered(body):
	_add_score(100)
