extends CanvasLayer




func _on_points_changed(score):
	$"Score Text".text = str(score)
