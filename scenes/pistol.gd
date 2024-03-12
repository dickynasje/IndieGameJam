extends "res://gun.gd"
class_name pistol
@export var dropped: bool = false
@onready var player_detect: Area2D = get_node("PlayerDetect")
# Called when the node enters the scene tree for the first time.
func _ready():
	if not dropped:
		player_detect.set_collision_mask_value(1, false)
		player_detect.set_collision_mask_value(2, false)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_class_name():
	return "pistol"
func _on_player_detect_body_entered(body: CharacterBody2D):
	if body != null:
		print("player in")
		body.notify_nearby_weapon(self)


func _on_player_detect_body_exited(body):
	print("player out")
	body.clear_nearby_weapon()
