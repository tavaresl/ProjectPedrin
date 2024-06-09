extends Node

@onready var parent: Character = $"../"
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	label.text = "Health: %s \nAttack Power: %s \nDefense: %s \nEvade: %s \nHaste: %s" % [parent.health, parent.attack_power, parent.defense, parent.evade_chance, parent.haste]
	label.queue_redraw()
