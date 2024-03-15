extends CharacterBody2D

var speed = 15
var direction = Vector2.RIGHT
var damage: int

func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)
	
func _process(_delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body: CharacterBody2D):
	if body.get_class_name() == "enemy":
		if body.HP < 0:
			queue_free()
		else:
			body.HP -= damage
			queue_free()
