extends Node2D
@onready var checkpointNode = $Marker2D
@onready var nextLevel = preload("res://scenes/level_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_first_fall_body_entered(body: CharacterBody2D):
	body.position = Vector2(checkpointNode.position)
	body.velocity = Vector2.ZERO
