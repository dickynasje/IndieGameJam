extends Node2D
class_name weapon
var bulletScene = preload("res://scenes/bullet.tscn")
@export var bullet: PackedScene
@export var bullet_count: int = 1
@export_range(0, 360) var spread: float = 0
@export_range(0, 200) var fireRate: float = 2.0
@export var damage: int = 2
@export var barrel_pos : Node2D
@export var max_ammo : int = 12 #default max ammo
@export var current_ammo : int = 12 #Starting ammo
@export var reload_time : float = 2.0
@export var recoil = 0.0
@export_enum("semi_auto", "auto") var shoot_mode : String
@export_enum("pistol", "machine_gun", "shotgun") var weapon_type : String
var is_reloading : bool = false
var is_shooting : bool = false
var is_held : bool = true
var trigger_pull : bool = false
var can_shoot = true


func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action("Shoot"):
		trigger_pull = true
		if shoot_mode == "semi_auto":
			shoot()
	if event.is_action_released("Shoot"):
		trigger_pull = false

func _physics_process(delta):
	# AIMING LOGIC
	look_at(get_global_mouse_position())
	var aim_dir = get_global_mouse_position() - global_position
	var aim_angle = atan2(aim_dir.y, aim_dir.x)
	if aim_dir.x < 0:
		scale.y = -1
	else:
		scale.y = 1
	
	print(trigger_pull)
	# SHOOTING
	if trigger_pull and shoot_mode == "auto":
		shoot()
 
func shoot():
	if can_shoot and current_ammo > 0 and not is_reloading and trigger_pull:
		can_shoot = false
		current_ammo -= 1
		for i in bullet_count:
			var new_bullet = bullet.instantiate()
			new_bullet.position = barrel_pos.global_position if barrel_pos else global_position
				
			if bullet_count == 1:
				new_bullet.rotation = global_rotation + randf_range(-deg_to_rad(recoil), deg_to_rad(recoil))
			else:
				var arc_rad = deg_to_rad(spread)
				var increment = arc_rad / (bullet_count-1)
				new_bullet.global_rotation = (
					global_rotation + 
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child", new_bullet)
		await get_tree().create_timer(1 / fireRate).timeout
		can_shoot = true
		if current_ammo ==0:
			reload()
		
func reload():
	is_reloading = true
	await get_tree().create_timer(reload_time).timeout
	current_ammo = max_ammo
	is_reloading = false
	
