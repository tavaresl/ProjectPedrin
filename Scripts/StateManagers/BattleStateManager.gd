extends Node
@export var initial_state: Constants.BattleStates

var _allowed_transitions = {
	Constants.BattleStates.ROUND_START: [Constants.BattleStates.DRAG_A_CART],
	Constants.BattleStates.DRAG_A_CART: [Constants.BattleStates.DROP_ON_REGION],
	Constants.BattleStates.DROP_ON_REGION: [Constants.BattleStates.PREVIEW_EFFECTS],
	Constants.BattleStates.PREVIEW_EFFECTS: [Constants.BattleStates.DRAG_A_CART, Constants.BattleStates.CONFIRM_SELECTION],
	Constants.BattleStates.CONFIRM_SELECTION: [Constants.BattleStates.RUN_TIMELINE],
	Constants.BattleStates.RUN_TIMELINE: [Constants.BattleStates.END_BATTLE, Constants.BattleStates.ROUND_START],
	Constants.BattleStates.END_BATTLE: [],
}
var _is_resetting = false

var current_state: Constants.BattleStates:
	get:
		return current_state
	set(new_state):
		if can_change_to(new_state) or _is_resetting:
			var previous_state = current_state
			current_state = new_state
			state_changed.emit(previous_state, current_state)
			_is_resetting = false
		else:
			push_warning("FORBIDDEN_STATE_TRANSITION: from " + Constants.BattleStatesNames[current_state] + " to " + Constants.BattleStatesNames[new_state])

signal state_changed(prev_state: Constants.BattleStates, new_state: Constants.BattleStates)

func can_change_to(new_state: Constants.BattleStates):
	return _allowed_transitions[current_state].has(new_state)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_gameplay_state_manager_state_changed(_prev_state, new_state: Constants.GameplayStates):
	if new_state == Constants.GameplayStates.ENTERED_BATTLE:
		_is_resetting = true
		current_state = initial_state
