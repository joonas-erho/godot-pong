extends Node2D

# Some variables to use in calculating where the CPU will move
var ball_pos: Vector2
var dist: int
var window_height: int
var pad_height: int

func _ready():
	# If we are playing as 2 players, disable this node as no CPU player is
	# needed
	if $"/root/GlobalData".is_multiplayer:
		set_process(false)
	
	window_height = get_viewport_rect().size.y
	pad_height = $"../ColorRect".get_size().y
	
func _process(delta):
	ball_pos = $"../../Ball".position
	dist = get_parent().position.y - ball_pos.y
	
	# We have this conditional to avoid dividing by zero.
	if abs(dist) > 0:
		# Calculate how fast to move and in which direction.
		var move_by = get_parent().get_parent().MAX_CPU_SPEED[$"/root/GlobalData".difficulty_setting] * delta * (dist / abs(dist))

		# Clamp movement so that the CPU pad can only move at a certain speed
		# at maximum. (The minimum clamp is just moving upwards.) This is
		# mainly noticable with lower difficulty settings, where the CPU pad
		# might not reach the ball in time.
		move_by = clamp(move_by, -$"../..".MAX_CPU_SPEED[$"/root/GlobalData".difficulty_setting], $"../..".MAX_CPU_SPEED[$"/root/GlobalData".difficulty_setting])
		get_parent().position.y -= move_by
		
		# Clamp the position so that the pad can't escape the screen.
		get_parent().position.y = clamp(get_parent().position.y, pad_height / 2, window_height - pad_height / 2)
