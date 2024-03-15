extends State

var can_transition

func enter():
	super.enter()
	can_transition = false
 
	animation_player.play("ranged_attack")
	await animation_player.animation_finished
 
	can_transition = true
