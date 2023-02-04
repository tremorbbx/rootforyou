extends Control
	
func _on_Start_pressed():
	if get_tree().change_scene("res://Scenes/Game.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the player game screen scene")

func _on_Settings_pressed():
	$Background/VBC1.visible = false
	$Background/Settings.visible = true

func _on_Back_pressed():
	$Background/Settings.visible = false
	$Background/VBC1.visible = true

func _on_Quit_pressed():
	get_tree().quit()
