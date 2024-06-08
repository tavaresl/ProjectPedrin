extends Node

@onready var character = $"../BaseCharacter"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = "Next round in %ss" % str(ceil($Timer.time_left))
	pass

func _on_timer_timeout():
	var effects = character.get_node("Effects").get_children()

	for effect in effects:
		if effect.remaining_duration <= 0:
			effect.cancel()
		else:
			effect.apply()

		if effect.canceled:
			effect.queue_free()
