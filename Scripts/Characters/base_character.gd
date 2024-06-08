extends AnimatableBody2D

class_name Character

@export var max_health: int
@export_range(1, 10) var base_attack_power: int
@export_range(1, 10) var base_defense: float
@export_range(0.1, 1.0, 0.1) var base_haste: float
@export_range(0.1, 1.0, 0.1) var base_evade: float

@export_category("Timeline")
@export var timeline_icon: Texture2D

@onready var health = max_health
@onready var attack_power = base_attack_power
@onready var defense = base_defense
@onready var haste = base_haste
@onready var evade = base_evade

func receive_damage(max_amount: int, commit: bool=false) -> int:
	if randf_range(0.1, 1.0) <= evade:
		return - 1
	
	var initial_health = health

	if max_amount < defense:
		return 0

	if commit:
		health -= max_amount - defense
	
	return initial_health - health

func apply_effect(effect: CharacterEffect) -> void:
	call_deferred("_apply_effect", effect)

func _apply_effect(effect: CharacterEffect):
	$Effects.add_child(effect)
	effect.position = $Sprite2D.position
	effect.target = self
