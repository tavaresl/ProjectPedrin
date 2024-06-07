@tool
extends Button

@export var state: Constants.BattleStates

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		disabled = %BattleStateManager.current_state == state or not %BattleStateManager.can_change_to(state)
		%BattleStateManager.state_changed.connect(_on_battle_state_manager_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Go to " + Constants.BattleStatesNames[state]
	if Engine.is_editor_hint():
		queue_redraw()

func _on_pressed():
	if not Engine.is_editor_hint():
		%BattleStateManager.current_state = state

func _on_battle_state_manager_state_changed(_prev_state, new_state: Constants.BattleStates):
	if not Engine.is_editor_hint():
		disabled = new_state == state or not %BattleStateManager.can_change_to(state)
