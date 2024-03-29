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


func get_class_name():
	return "pistol"
func _on_player_detect_body_entered(body: CharacterBody2D):
	if body != null:
		if body.get_class_name() == "enemy":
			pass
		else:
			body.notify_nearby_weapon(self)


func _on_player_detect_body_exited(body: CharacterBody2D):
	if body.get_class_name() == "enemy":
		pass
	else:
		body.clear_nearby_weapon()
