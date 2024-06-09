extends Node2D


func _ready():
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("scroll_background")
	await get_tree().create_timer(7.0).timeout
	$AnimationPlayer.play("scroll_background")
