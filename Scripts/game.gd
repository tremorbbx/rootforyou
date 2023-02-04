extends Node

func _physics_process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
			print ("An unexpected error occured when trying to switch to the player game screen scene")
