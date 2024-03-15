extends CharacterBody2D
@onready var player = get_parent().find_child("Player")
@onready var sprite = $Sprite2D
@onready var progress_bar = %ProgressBar

var direction : Vector2

var HP = 4:
	set(value):
		if value < HP:
			find_child("FiniteStateMachine").change_state("Stagger")
 
		HP = value
		progress_bar.value = value
 
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

func _process(_delta):
	direction = player.position - position
 
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func get_class_name():
	return "enemy"
