extends Control

# Functions for the buttons in the Difficulty Selection menu.
# Each difficulty setting sets the global difficulty flag and then
# loads the gameplay.
func _on_easy_pressed():
	$"/root/GlobalData".difficulty_setting = 0
	get_tree().change_scene_to_file("res://Gameplay.tscn")

func _on_medium_pressed():
	$"/root/GlobalData".difficulty_setting = 1
	get_tree().change_scene_to_file("res://Gameplay.tscn")

func _on_hard_pressed():
	$"/root/GlobalData".difficulty_setting = 2
	get_tree().change_scene_to_file("res://Gameplay.tscn")

func _on_insane_pressed():
	$"/root/GlobalData".difficulty_setting = 3
	get_tree().change_scene_to_file("res://Gameplay.tscn")

# Leave this scene.
func _on_return_to_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
