extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -400.0

var current_state

enum State {Run, Idle, Jump, Shoot, Hurt}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	falling(delta)
	handle_movement()
	move_and_slide()
	#determine mouse position for gun sprite
	#print((get_global_mouse_position()-global_position).normalized())
func falling(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement():
		# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 60.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
