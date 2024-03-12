extends Area2D

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
@onready var transition_cooldown: Timer = get_node("Timer")
@export var scene_path: String

func _ready():
	transition_cooldown.wait_time = 1.0
	transition_cooldown.one_shot = true
	transition_cooldown.start()

func _on_body_entered(_body: CharacterBody2D):
	if transition_cooldown.time_left == 0:
		collision_shape.set_deferred("disabled", true)
		SceneTransition.start_transition_to(scene_path)
		transition_cooldown.start()

