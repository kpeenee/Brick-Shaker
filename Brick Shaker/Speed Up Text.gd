extends Label

onready var tween = $Tween
onready var sound = $"Speed Up Sound"
var speed_up_sound = preload("res://Assets/Sounds/Speed Up.wav")

func _scale():
	tween.interpolate_property(self,"rect_scale", rect_scale,Vector2(2,2),1,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	tween.start()
	sound.play()


func _on_Tween_tween_completed(object, key):
	self.visible = false
	rect_scale = Vector2(1,1)
