@tool
extends Sprite2D

@onready var ray_cast_2d = $"../RayCast2D"
@export var color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	draw_line(position, Vector2(position.x, ray_cast_2d.target_position.y), color, 8)
