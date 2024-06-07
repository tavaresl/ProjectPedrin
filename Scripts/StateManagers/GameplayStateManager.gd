extends Node

@export var initial_state: Constants.GameplayStates

var _allowed_transitions = {
	Constants.GameplayStates.WAITING_ON_TAVERN: [Constants.GameplayStates.ENTERED_DUNGEON],
	Constants.GameplayStates.ENTERED_DUNGEON: [Constants.GameplayStates.ENTERED_BATTLE],
	Constants.GameplayStates.ENTERED_BATTLE: [Constants.GameplayStates.VICTORY, Constants.GameplayStates.DEFEAT],
	Constants.GameplayStates.VICTORY: [Constants.GameplayStates.ENTERED_BATTLE],
	Constants.GameplayStates.DEFEAT: [Constants.GameplayStates.WAITING_ON_TAVERN],
}

var current_state: Constants.GameplayStates:
	get:
		return current_state
	set(new_state):
		if can_change_to(new_state):
			var previous_state = current_state
			current_state = new_state
			state_changed.emit(previous_state, current_state)
		else:
			push_warning("FORBIDDEN_STATE_TRANSITION: from " + str(current_state) + " to " + str(new_state))

signal state_changed(prev_state: Constants.GameplayStates, new_state: Constants.GameplayStates)

func can_change_to(new_state: Constants.GameplayStates):
	return _allowed_transitions[current_state].has(new_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
