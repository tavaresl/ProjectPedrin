@tool
extends Node2D

class_name Timeline

enum TimelineStates {PREVIEWING, RUNNING, WAITING_ACTION_COMPLETE, FINISHED}

@export var player_characters: Array[Character] = []:
	get:
		return player_characters
	set(value):
		player_characters = value
		if player_characters != null:
			_sort_characters()
		notify_property_list_changed()

@export var enemy_characters: Array[Character] = []:
	get:
		return enemy_characters
	set(value):
		enemy_characters = value
		if player_characters != null:
			_sort_characters()
		notify_property_list_changed()

@export_range(480.0, 1024.0, 1.0, "suffix:px") var width: float:
	get:
		return width
	set(new_width):
		width = new_width
		_set_dropzones()
		_sort_characters()
		notify_property_list_changed()

@export var state: TimelineStates

@export_group("Dropzones")
@export_range(3, 5, 1) var sections: int:
	get:
		return sections
	set(num_of_sections):
		sections = num_of_sections
		_set_dropzones()
		notify_property_list_changed()
@export_range(0, 64, 1, "suffix:px") var gutter: int:
	get:
		return gutter
	set(value):
		gutter = value
		_set_dropzones()
		notify_property_list_changed()

@export_group("Needle")
@export_range(32.0, 128.0, 1.0, "or_less", "or_greater", "hide_slider", "suffix: px/s") var needle_speed: float

@export_category("Assets")
@export var dropzone_prefab: PackedScene
@export var timeline_character_prefab: PackedScene:
	get:
		return timeline_character_prefab
	set(value):
		timeline_character_prefab = value
		_sort_characters()
		notify_property_list_changed()

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		state = TimelineStates.RUNNING

	_set_dropzones()
	_sort_characters()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == TimelineStates.FINISHED:
		return
	elif $Needle.position.x >= width / 2:
		state = TimelineStates.FINISHED
	elif state == TimelineStates.RUNNING:
		$Needle.position += Vector2.RIGHT * needle_speed * delta

func _set_dropzones():
	if not has_node("Dropzones"):
		return

	for child in $Dropzones.get_children():
		child.queue_free()

	for n in range(sections):
		var dropzone = dropzone_prefab.instantiate()
		var shape: RectangleShape2D = dropzone.get_node("CollisionShape2D").shape as RectangleShape2D
		var num_of_gutters = sections - 1
		var dropzone_width = ceil((width - gutter * num_of_gutters) / sections)
		shape.size.x = dropzone_width

		dropzone.position.x = (-width / 2) + dropzone_width / 2 + n * dropzone_width + n * gutter

		$Dropzones.add_child(dropzone)

func _sort_characters():
	if not has_node("Characters"):
		return

	for child in $Characters.get_children():
		child.queue_free()

	var timeline_characters: Array[TimelineCharacter] = []

	for character in enemy_characters:
		var timeline_character = timeline_character_prefab.instantiate() as TimelineCharacter
		timeline_character.character = character
		timeline_character.side = Constants.CharacterSide.ENEMY
		timeline_characters.append(timeline_character)

	for character in player_characters:
		var timeline_character = timeline_character_prefab.instantiate() as TimelineCharacter
		timeline_character.character = character
		timeline_character.side = Constants.CharacterSide.ALLY
		timeline_characters.append(timeline_character)
	
	timeline_characters.sort_custom(func(a, b): return a.character.base_haste > b.character.base_haste)

	if Engine.is_editor_hint():
		for timeline_character in timeline_characters:
			timeline_character.position.x = (1 - timeline_character.character.base_haste) * width - width / 2
			$Characters.add_child(timeline_character)
	else:
		for timeline_character in timeline_characters:
			timeline_character.position.x = (1 - timeline_character.character.base_haste) * width - width / 2
			$Characters.add_child(timeline_character)

func _on_character_stat_changed(stat_name: String):
	if stat_name == "Base_Haste":
		_sort_characters()

func reset_needle():
	$Needle.position = Vector2( - width / 2, -64)
	
func set_state(newstate):
	state = newstate
	
func force_reset_needle():
	for item in enemy_characters:
		if(item != null):
			if(item.target == null or item.target.dead):
				var filteredAvailable = player_characters.filter(func (x): return not x.dead )
				item.target = filteredAvailable[0] if not filteredAvailable.is_empty() else null
			item.performed_action = false
		
	for item in player_characters:
		if(item != null):
			if(item.target == null or item.target.dead):
				var filteredAvailable = enemy_characters.filter(func (x): return not x.dead )
				item.target = filteredAvailable[0] if not filteredAvailable.is_empty() else null
			item.performed_action = false
		
	set_state(TimelineStates.RUNNING)
	reset_needle()

func refresh_character_targets():
	for item in enemy_characters:
		if(item != null):
			if(item.target == null or item.target.dead):
				var filteredAvailable = player_characters.filter(func (x): return not x.dead )
				item.target = filteredAvailable[0] if not filteredAvailable.is_empty() else null
		
	for item in player_characters:
		if(item != null):
			if(item.target == null or item.target.dead):
				var filteredAvailable = enemy_characters.filter(func (x): return not x.dead )
				item.target = filteredAvailable[0] if not filteredAvailable.is_empty() else null


func _on_needle_hit_character(timeline_character):
	if state == TimelineStates.RUNNING and not timeline_character.character.performed_action and not timeline_character.dead:
		refresh_character_targets()
		if timeline_character.character.target != null and not timeline_character.character.target.dead:
			state = TimelineStates.WAITING_ACTION_COMPLETE
			timeline_character.character.action_completed.connect(_on_character_action_complete.bind(timeline_character.character))
			timeline_character.character.target.died.connect(_on_character_target_died.bind(timeline_character.character.target))
			timeline_character.character.perform_action()

func _on_character_action_complete(character):
	state = TimelineStates.RUNNING
	character.action_completed.disconnect(_on_character_action_complete)

func _on_character_target_died(target: Character):
	target.died.disconnect(_on_character_target_died)
