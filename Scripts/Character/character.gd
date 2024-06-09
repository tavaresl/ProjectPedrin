extends Node2D

func play_idle():
	$CharacterAnimation.play("character_animation/character_idle")
	pass

func play_walk():
	$CharacterAnimation.play("character_animation/character_walking")
	pass

func play_attack():
	$CharacterAnimation.play("character_animation/character_attack")
	pass

func play_hurt():
	$CharacterAnimation.play("character_animation/character_hurt")
	pass

func play_death():
	$CharacterAnimation.play("character_animation/character_dying")
	pass


func _on_character_animation_animation_finished(anim_name):
	if anim_name != "character_animation/character_dying":
		play_idle()


func _on_character_animation_animation_started(anim_name):
	pass
