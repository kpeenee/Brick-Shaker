extends Node2D

onready var main_menu = $Menu
onready var tutorial = $Tutorial
onready var brick = $Brick
onready var high_score_text = $"High Score Text"

const SAVE_FILE_LOCATION = "user://brickshaker.save"

func _ready():
	_load_score()

func _on_Play_Button_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_How_To_Play_pressed():
	for i in main_menu.get_child_count():
		main_menu.get_child(i).visible = false
		
	for i in tutorial.get_child_count():
		tutorial.get_child(i).visible = true
		
	brick.visible = true
	
func _load_score():
	var high_score
	var save_file = File.new()
	if save_file.file_exists(SAVE_FILE_LOCATION):
		save_file.open(SAVE_FILE_LOCATION,File.READ)
		high_score = save_file.get_var()
		save_file.close()
	high_score_text.text = "Highscore: " + str(high_score)


func _on_Got_It_Button_pressed():
	for i in main_menu.get_child_count():
		main_menu.get_child(i).visible = true
		
	for i in tutorial.get_child_count():
		tutorial.get_child(i).visible = false
		
	brick.visible = false
