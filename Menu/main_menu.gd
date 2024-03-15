class_name mainmenu
extends Control
@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var start_level = preload("res://scenes/tutorial_level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	play.button_down.connect(on_play_pressed)
	quit.button_down.connect(on_exit_pressed)

func on_play_pressed()-> void:
	SceneTransition.start_transition_to("res://scenes/tutorial_level.tscn")
	pass

func on_exit_pressed()-> void:
	get_tree().quit()
	pass
