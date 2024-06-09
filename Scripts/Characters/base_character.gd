@tool
extends Node2D

class_name Character

signal action_completed()
signal died()


@export var max_health: int
@export_range(1, 10) var base_attack_power: int:
	get:
		return base_attack_power
	set(value):
		base_attack_power = value
		notify_property_list_changed()

@export_range(1, 10) var base_defense: float:
	get:
		return base_defense
	set(value):
		base_defense = value
		notify_property_list_changed()

@export_range(0.01, 1.00, 0.01) var base_haste: float:
	get:
		return base_haste
	set(value):
		base_haste = value
		notify_property_list_changed()

@export_range(0.1, 100.0, 0.1, "suffix:%") var base_evade_chance: float:
	get:
		return base_evade_chance
	set(value):
		base_evade_chance = value
		notify_property_list_changed()

@export_group("Combat")
@export var target: Character
@export var board_node: PackedScene:
	get:
		return board_node
	set(val):
		board_node = val
		_instantiate_node()
		notify_property_list_changed()

@export_group("Timeline")
@export var timeline_icon: Texture2D:
	get:
		return timeline_icon
	set(value):
		timeline_icon = value
		notify_property_list_changed()

@onready var health = max_health
@onready var attack_power = base_attack_power
@onready var defense = base_defense
@onready var haste = base_haste
@onready var evade_chance = base_evade_chance

var performed_action = false

var dead : bool = false
# :
#	get:
#		return health <= 0

func _ready():
	_instantiate_node()

func receive_damage(max_amount: int, commit: bool=false) -> int:
	if randf_range(0.1, 1.0) <= evade_chance / 100:
		return - 1
	
	var initial_health = health

	if max_amount < defense:
		return 0

	if commit:
		var animation_player = $BoardCharacter.get_child(0).get_node("CharacterAnimation") as AnimationPlayer

		health = clamp(health - max_amount - defense, 0, max_health)

		if health == 0:
			dead = true
			animation_player.play("character_animation/character_dying")
			died.emit()
		else:
			animation_player.play("character_animation/character_hurt")
	
	return initial_health - health

func apply_effect(effect: CharacterEffect) -> void:
	call_deferred("_apply_effect", effect)

func _apply_effect(effect: CharacterEffect):
	$Effects.add_child(effect)
	effect.position = $Sprite2D.position
	effect.target = self

func pick_a_target(targets_pool: Array[Character]):
	target = targets_pool[randi_range(0, targets_pool.size() - 1)]

func perform_action():
	var animation_player = $BoardCharacter.get_child(0).get_node("CharacterAnimation") as AnimationPlayer

	animation_player.play("character_animation/character_attack")
	
	await animation_player.animation_finished
	target.receive_damage(base_attack_power, true)

	await target.get_node("BoardCharacter").get_child(0).get_node("CharacterAnimation").animation_finished
	performed_action = true
	action_completed.emit()

func _instantiate_node():
	for child in $BoardCharacter.get_children():
		child.queue_free()

	if board_node == null:
		return

	var board_node_instance = board_node.instantiate()

	$BoardCharacter.add_child(board_node_instance)
