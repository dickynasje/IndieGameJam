extends "res://gun.gd"

@export var dropped: bool = false
@onready var player_detect: Area2D = get_node("PlayerDetect")
# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_type = "machine_gun"
	if not dropped:
		player_detect.set_collision_mask_value(1, false)
		player_detect.set_collision_mask_value(2, false)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detect_body_entered(body):
	if body != null:
		player_detect.set_collision_mask_value(1, false)
		player_detect.set_collision_mask_value(2, false)
		body.pick_up_weapon(self)
		position = Vector2.ZERO
	pass # Replace with function body.
