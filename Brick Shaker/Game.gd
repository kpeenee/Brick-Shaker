extends Node2D

onready var game_over =  $"Game Over"
onready var score_text = $"Score/Score Text"
onready var high_score_text = $"Game Over/High score"
onready var final_score_text = $"Game Over/Score"
onready var play_again_button = $"Game Over/TouchScreenButton"
onready var play_again_text = $"Game Over/Button Text"
onready var speed_up_text = $"Speed Up/Speed Up Text"


var high_score = 0
var min_cap = 15


const SAVE_FILE_PATH = "user://brickshaker.save"

func _ready():
	_load_score()

func _load_score():
	var save_file = File.new()
	if save_file.file_exists(SAVE_FILE_PATH):
		save_file.open(SAVE_FILE_PATH,File.READ)
		high_score = save_file.get_var()
		save_file.close()
		
func _save_score(score):
	var save_file = File.new()
	save_file.open(SAVE_FILE_PATH,File.WRITE)
	save_file.store_var(score)
	save_file.close()

func _on_Bricks_game_over(final_score):
	score_text.visible = false
	game_over.get_child(0).visible = true
	high_score_text.visible = true
	final_score_text.visible = true
	play_again_button.visible = true
	play_again_text.visible = true
	
	final_score_text.text ="SCORE: " + str(final_score)
	
	if final_score > high_score:
		high_score_text.text ="HIGH SCORE: " + str(final_score)
		_save_score(final_score)
	else:
		high_score_text.text ="HIGH SCORE: " + str(high_score)
		
	$"Bricks".queue_free()
	


func _on_TouchScreenButton_pressed():
	get_tree().reload_current_scene()


func _on_Speed_Up_Timer_timeout():
	speed_up_text.visible = true 
	speed_up_text._scale()
	$"Speed Up Timer".wait_time -= 2
	$Bricks._add_score(($Bricks.get_child_count() - 1) * 5)
	
	if $"Speed Up Timer".wait_time < min_cap:
		$"Speed Up Timer".wait_time = min_cap
