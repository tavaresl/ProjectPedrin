extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_D) and not visible:
		visible = true
	elif not Input.is_key_pressed(KEY_D) and visible:
		visible = false
