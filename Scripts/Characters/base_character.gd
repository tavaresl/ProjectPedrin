extends AnimatableBody2D

class_name Character

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

@export_category("Timeline")
@export var timeline_icon: Texture2D:
	get:
		return timeline_icon
	set(value):
		timeline_icon = value
		notify_property_list_changed()

var health = max_health
var attack_power = base_attack_power
var defense = base_defense
var haste = base_haste
var evade_chance = base_evade_chance

func receive_damage(max_amount: int, commit: bool=false) -> int:
	if randf_range(0.1, 1.0) <= evade_chance / 100:
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
