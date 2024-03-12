extends CanvasLayer

var new_scene: String

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func start_transition_to(scene_path: String):
	new_scene = scene_path
	animation_player.play("change_scene")
	
func change_scene():
	assert(get_tree().change_scene_to_file(new_scene) == OK)
