extends Control

@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
# Called when the node enters the scene tree for the first time.
func _ready():
	quit.button_down.connect(on_exit_pressed)
	pass # Replace with function body.


func on_exit_pressed()-> void:
	get_tree().quit()
	pass
