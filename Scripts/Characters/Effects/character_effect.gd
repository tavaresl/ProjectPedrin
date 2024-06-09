@tool
extends Node2D

class_name CharacterEffect

enum EffectState {UNCASTED, CASTING, CASTED}

@export var health: int
@export var attack_power: int
@export var defense: int
@export_range(0.0, 1.0, 0.1) var evade: float
@export_range(0.1, 1.0, 0.1) var haste: float

@export_multiline var description: String

@export_category("Options")
@export var target: Character
@export var cancellable: bool
@export var cumulative: bool
@export_range(1, 5, 1, "suffix: rounds") var duration: int

@export_category("Visual")
@export var icon: Texture2D:
  get:
    return icon
  set(new_value):
    icon = new_value
    $Sprite2D.texture = new_value
    notify_property_list_changed()

@export var small_icon: Texture2D
@export var tint: Color = Color.WHITE:
  get:
    return tint
  set(value):
    tint = value
    $Sprite2D.modulate = value
    notify_property_list_changed()

@onready var applied = false
@onready var remaining_duration = duration
@onready var canceled = false
@onready var state = EffectState.UNCASTED

func apply():
  if target == null:
    push_error("Effect with no associated target")
    return

  if canceled:
    return

  if state == EffectState.UNCASTED:
    cast()
  
  if not applied or cumulative:
    target.health = clamp(target.health + health, 1, target.max_health)
    target.attack_power += attack_power
    target.defense += defense
    target.evade_chance += evade
    target.haste += haste
  
  applied = true
  remaining_duration -= 1

func cancel():
  if not applied:
    return

  if not canceled and (remaining_duration == 0 or cancellable):
    target.attack_power -= attack_power
    target.defense -= defense
    target.evade_chance -= evade
    target.haste -= haste

  canceled = true

func cast():
  state = EffectState.CASTING
  $AnimationPlayer.play("Cast")

func _on_animation_player_animation_finished(anim_name: StringName):
  if anim_name == "Cast":
    state = EffectState.CASTED
