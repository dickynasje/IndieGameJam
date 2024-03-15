extends Node2D
class_name State
#@onready var debug = owner.find_child("debug")
@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)
 
func exit():
	set_physics_process(false)
	
func transition():
	pass

func _physics_process(_delta):
	transition()
	#debug.text = name