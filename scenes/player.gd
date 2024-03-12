extends CharacterBody2D
@onready var weapons: Node2D = get_node("Weapons")
var current_weapon: Node2D
const SPEED = 350.0
const JUMP_VELOCITY = -400.0
var nearby_weapon: Node2D = null
var current_state

var dodge_chance: float = 20.0
var armor: int = 25
var HP: int = 100
var money: int = 0

enum State {Run, Idle, Jump, Shoot, Hurt}
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	_restore_previous_state()
	current_weapon = weapons.get_child(0)
	
func _input(event):
	if event.is_action_pressed("SwitchWeapon") and nearby_weapon != null:
		switch_weapon()
	
func _physics_process(delta):
	# Add the gravity.
	falling(delta)
	handle_movement()
	move_and_slide()
	#print(get_parent().get_children())
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
	if nearby_weapon.get_class_name() != current_weapon.get_class_name():
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
	#Datasave.weapons.append(weapon.duplicate(8))
	#Datasave.weaponbarrelpos = weapon.get_node("Marker2D").duplicate()

func drop_weapon():
	if current_weapon == null:
		return
	var drop_position = nearby_weapon.global_position
	current_weapon.show()
	
	print(current_weapon.get_parent())
	current_weapon.get_parent().remove_child(current_weapon)
	get_parent().call_deferred("add_child", current_weapon)
	current_weapon.global_position = drop_position
	current_weapon.rotation = 0
	current_weapon.dropped = true
	current_weapon.player_detect.set_collision_mask_value(1, true)
	current_weapon.player_detect.set_collision_mask_value(2, true)
	current_weapon.scale.y=1
	current_weapon = null
	#Datasave.weapons.clear()
	#Datasave.weaponbarrelpos = null

func notify_nearby_weapon(weapon: Node2D):
	nearby_weapon = weapon

func clear_nearby_weapon():
	nearby_weapon = null
	
func _restore_previous_state():
	self.HP = Datasave.HP
	self.armor = Datasave.armor
	self.dodge_chance = Datasave.dodge_chance
	self.money = Datasave.money
	#next scene init
	#consider player always spawn with a default gun
	#add the weapon to the children -> set current_weapon to new children -> remove old Gun from list
	# Clear existing weapons in the weapons node
	#for child in weapons.get_children():
		#weapons.remove_child(child)
#
	#
	#for guns in Datasave.weapons:
		#weapons.add_child(guns)
		#guns.owner = self
#
	#if weapons.get_child_count() > 0:
		#current_weapon = weapons.get_child(0)
		#current_weapon.show()
	
	
	
