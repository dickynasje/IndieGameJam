class_name Slime
extends CharacterBody2D
@onready var wall_raycast_left: RayCast2D = $Wall_checks/Wall_Raycast_Left
@onready var wall_raycast_right: RayCast2D = $Wall_checks/Wall_Raycast_Right
@onready var floor_raycast_left: RayCast2D = $Floor_Checks/Floor_Raycast_Left
@onready var floor_raycast_right: RayCast2D = $Floor_Checks/Floor_Raycast_Right
@onready var player_cast_2d: RayCast2D = $Player_Tracker_Pivot/Player_Tracker_Raycast
@onready var player_tracker_pivot: Node2D = $Player_Tracker_Pivot
@onready var chase_timer = $Chase_Timer as Timer
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var wander_speed: float = 40.0
@export var chase_speed: float = 40.0
@export var explodeSlimeParticle: PackedScene
@export var HP: int = 4
var current_speed: float = 0.0
var player_found: bool = false
var player: PlayerEntity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum States{
	Wander,
	Chase,
	Dead
}
var current_state = States.Wander

func _ready():
	player = get_parent().get_child(0)
	chase_timer.timeout.connect(on_timer_timeout)

func _physics_process(delta):
	#player = get_tree().get_first_node_in_group("Player")
	handle_vision()
	track_player()
	handle_movement()
	move_and_slide()
	falling(delta)
	handle_anim()
	if HP <= 0:
		#Play Death animation
		current_state = States.Dead
		await get_tree().create_timer(0.6).timeout
		var new_particle = explodeSlimeParticle.instantiate()
		new_particle.position = global_position
		new_particle.position.y -= 8
		get_tree().root.call_deferred("add_child", new_particle)
		new_particle.emitting = true
		queue_free()
	pass

func falling(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_movement() -> void:
	var direction = global_position - player.global_position
	
	if current_state == States.Wander:
		if !floor_raycast_right.is_colliding():
			current_speed = -wander_speed
		if !floor_raycast_left.is_colliding():
			current_speed = wander_speed
		if wall_raycast_right.is_colliding():
			current_speed = -wander_speed
		if wall_raycast_left.is_colliding():
			current_speed = wander_speed
	velocity.x = current_speed
	if current_state == States.Chase:
		if player_found == true:
			if direction.x < 0:
				sprite.set_flip_h(true)
				current_speed = chase_speed
			else:
				sprite.set_flip_h(false)
				current_speed = -chase_speed
func track_player():
	if player == null:
		return
	var direction_to_player : Vector2 = Vector2(player.position.x, player.position.y) - player_cast_2d.position
	
	player_tracker_pivot.look_at(direction_to_player)
	
func handle_vision():
	if player_cast_2d.is_colliding():
		var collision_result = player_cast_2d.get_collider()
		
		if collision_result != player:
			return
		else:
			current_state = States.Chase
			chase_timer.start(1)
			player_found = true
	else:
		player_found = false

func on_timer_timeout() -> void:
	if player_found == false:
		current_state = States.Wander
		

func get_class_name():
	return "enemy"

func handle_anim():
	if current_state == States.Wander or current_state == States.Chase:
		anim.play("walk")
	elif current_state == States.Dead:
		anim.play("death")
