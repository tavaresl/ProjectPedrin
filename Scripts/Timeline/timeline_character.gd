@tool
extends Node2D

class_name TimelineCharacter

@export var character: Character:
	get:
		return character
	set(new_character):
		character = new_character
		notify_property_list_changed()

@export var side: Constants.CharacterSide

@export_group("Colors")
@export var enemy_tint: Color = Color.INDIAN_RED
@export var ally_tint: Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if character != null and character.timeline_icon != null:
		$Sprite2D.texture = character.timeline_icon
	
	$NinePatchRect.modulate = enemy_tint if side == Constants.CharacterSide.ENEMY else ally_tint
