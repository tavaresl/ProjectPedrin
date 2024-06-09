extends Node2D

class_name TimelineNeedle2D

signal hit_character(character: Character)

func _process(delta):
	if $RayCast2D.is_colliding():
		if($RayCast2D.get_collider() != null):
			var character = $RayCast2D.get_collider().get_parent()
			hit_character.emit(character)
