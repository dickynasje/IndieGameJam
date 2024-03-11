extends CharacterBody2D
@onready var weapons: Node2D = get_node("Weapons")
var current_weapon: Node2D
const SPEED = 350.0
const JUMP_VELOCITY = -400.0
var nearby_weapon: Node2D = null
var current_state

enum State {Run, Idle, Jump, Shoot, Hurt}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	current_weapon = weapons.get_child(0)
	
func _input(event):
	if event.is_action_pressed("SwitchWeapon") and nearby_weapon != null:
		switch_weapon()
	
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

func switch_weapon():
	if current_weapon != null:
		drop_weapon()
	nearby_weapon.player_detect.set_collision_mask_value(1, false)
	nearby_weapon.player_detect.set_collision_mask_value(2, false)
	pick_up_weapon(nearby_weapon)
	nearby_weapon = null
	

func pick_up_weapon(weapon: Node2D):
	if current_weapon != null:
		current_weapon.hide()
		
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	weapon.dropped = false
	weapon.position = Vector2.ZERO
	current_weapon = weapon
	pass

func drop_weapon():
	if current_weapon == null:
		return
	var drop_position = nearby_weapon.global_position
	current_weapon.show()
	current_weapon.get_parent().remove_child(current_weapon)
	get_tree().root.add_child(current_weapon)
	current_weapon.global_position = drop_position
	current_weapon.rotation = 0
	current_weapon.dropped = true
	current_weapon.player_detect.set_collision_mask_value(1, true)
	current_weapon.player_detect.set_collision_mask_value(2, true)
	current_weapon.scale.y=1
	print(current_weapon.global_position)
	current_weapon = null

func notify_nearby_weapon(weapon: Node2D):
	nearby_weapon = weapon

func clear_nearby_weapon():
	nearby_weapon = null
	
