extends State

func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	animation_player.play("boss_death")
	await get_tree().create_timer(2).timeout
	SceneTransition.start_transition_to("res://Menu/congrats.tscn")
