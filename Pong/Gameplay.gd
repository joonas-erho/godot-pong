extends ColorRect

# Speed that the player pads can move
const PAD_SPEED := 350

# Speeds for the CPU pad, depending on difficulty chosen
const MAX_CPU_SPEED := [115, 350, 450, 600]

# Score for players 1 and 2 (left and right)
var score := [0, 0]

func _ready():
	# Once scene is loaded, wait for 2.5 seconds and then launch ball to left
	# player.
	await get_tree().create_timer(2.5).timeout
	$Ball.spawn_ball(-1)

# Update score, label and relaunch ball after a timeout.
# Always launch the ball to the player that was scored against.
func _on_left_goal_body_entered(body):
	score[1] += 1
	$"UI/Right Score".text = str(score[1])
	await get_tree().create_timer(1.0).timeout
	$Ball.spawn_ball(-1)

func _on_right_goal_body_entered(body):
	score[0] += 1
	$"UI/Left Score".text = str(score[0])
	await get_tree().create_timer(1.0).timeout
	$Ball.spawn_ball(1)

# Listen for input, on "esc" return to menu instantly.
func _process(delta):
	if Input.is_action_pressed("back_to_menu"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")


