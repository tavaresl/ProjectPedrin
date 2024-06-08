extends Node

@onready var character = $"../BaseCharacter"

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons = get_node("ButtonsContainer").get_children()

	for button in buttons:
		button.pressed.connect(_on_effect_button_pressed.bind(button))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_effect_button_pressed(button: Button):
	var effect = button.get_child(0)
	var effect_clone = effect.duplicate()
	character.apply_effect(effect_clone)
