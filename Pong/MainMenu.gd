extends Control

# The buttons load either the gameplay or difficulty selection.
# Pressing these buttons also sets the global flag so the gameplay knows
# whether or not its multiplayer or singleplayer.
func _on_play_sp_button_pressed():
	$"/root/GlobalData".is_multiplayer = false
	get_tree().change_scene_to_file("res://DifficultySelection.tscn")

func _on_play_mp_button_pressed():
	$"/root/GlobalData".is_multiplayer = true
	get_tree().change_scene_to_file("res://Gameplay.tscn")

# Exit the game.
func _on_exit_button_pressed():
	get_tree().quit()

