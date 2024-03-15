extends Node

@onready var playernode = $Entity_Container/Player
@onready var checkpointNode = $Marker2D

const charaLines: Array[String] = [
	"I never expected to be transported here...",
	"Luckily i brought my reliable pistol!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	Dialogmanager.start_dialog(playernode.global_position, charaLines)
	pass # Replace with function body.

 


func _on_first_fall_body_entered(body: CharacterBody2D):
	body.position = Vector2(checkpointNode.position)
	body.velocity = Vector2.ZERO
	pass # Replace with function body.
