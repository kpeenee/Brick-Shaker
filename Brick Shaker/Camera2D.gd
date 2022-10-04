extends Camera2D

var decay = 0.5
var max_offset = Vector2(10,20)
var max_roll = 50

var trauma = 0.0
var trauma_power = 2

func _ready():
	randomize()
	
func _add_trauma(amount):
	trauma = min(trauma + amount, 1)
	
func _process(delta):
	if trauma != 0:
		trauma = max(trauma - (decay * delta), 0)
		_shake()
		
func _shake():
	var amount = pow(trauma, trauma_power)
	
	rotation = max_roll * amount * rand_range(-1,1)
	offset.x = max_offset.x * amount * rand_range(-1,1)
	offset.y = max_offset.y * amount * rand_range(-1,1)
	





func _ball_camera_shake(amount):
	_add_trauma(amount)
