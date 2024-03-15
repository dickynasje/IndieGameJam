extends CanvasLayer

@onready var label: Label = $MarginContainer/Label

var maingun
var current_ammo: int
var max_ammo: int
var PlayerNode: CharacterBody2D
var entContainer
var WeaponsNode: Node2D
signal gunChange
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	if maingun == null:
		maingun = get_weapon()
	else:
		max_ammo = maingun.max_ammo
		current_ammo = maingun.current_ammo
	var ammoUI = "Ammo %d/%d"
	var formatAmmo = ammoUI % [current_ammo, max_ammo]
	label.set_text(formatAmmo)
	
	
	pass
	
func get_weapon():
	entContainer = get_tree().get_root().find_child("Entity_Container", true, false)
	WeaponsNode = entContainer.get_node("Player/Weapons")
	return WeaponsNode.get_child(0)
	
func refresh_weapon():
	maingun = null
