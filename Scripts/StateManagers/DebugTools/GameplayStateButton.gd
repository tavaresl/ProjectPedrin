@tool
extends Button

@export var state: Constants.GameplayStates

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		disabled = %GameplayStateManager.current_state == state or not %GameplayStateManager.can_change_to(state)
		%GameplayStateManager.state_changed.connect(_on_gameplay_state_manager_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Go to " + Constants.GameplayStatesNames[state]
	if Engine.is_editor_hint():
		queue_redraw()

func _on_pressed():
	if not Engine.is_editor_hint():
		%GameplayStateManager.current_state = state

func _on_gameplay_state_manager_state_changed(_prev_state, new_state: Constants.GameplayStates):
	if not Engine.is_editor_hint():
		disabled = new_state == state or not %GameplayStateManager.can_change_to(state)
