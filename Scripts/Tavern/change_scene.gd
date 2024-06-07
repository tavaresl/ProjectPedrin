extends BaseButton

@export var next_scene : String

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/"+next_scene+".tscn")
