extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = %GameplayStateManager.current_state == Constants.GameplayStates.ENTERED_BATTLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_gameplay_state_manager_state_changed(
	_prev_state: Constants.GameplayStates,
	new_state: Constants.GameplayStates,
):
	visible = new_state == Constants.GameplayStates.ENTERED_BATTLE
