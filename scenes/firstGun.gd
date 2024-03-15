extends Area2D

var gunFound = false
const foundSMG: Array[String] = [
	"Would you look at that the good ole PM5",
	"I wonder how did this end up here"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body:CharacterBody2D):
	if body != null:
		if body.get_class_name() == "enemy":
			pass
		elif !gunFound:
			Dialogmanager.start_dialog(body.global_position, foundSMG)
			gunFound = true
			
