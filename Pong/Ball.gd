extends CharacterBody2D

# Initial speed
const SPEED_ON_SPAWN : int = 550

# Acceleration on hitting pad
const ACCELERATION : int = 50

# Multiplies the bounce angle of the ball so that it can't exceed a realistic
# angle.
const MAX_BOUNCE_ANGLE: float = 0.5

var window_size : Vector2

# Current speed and direction of ball
var current_speed : int
var direction : Vector2

func _ready():
	window_size = get_viewport_rect().size

# Spawn ball to middle of screen and launch it either to left or right
# depending on who scored.
func spawn_ball(dir):
	position.x = window_size.x / 2
	position.y = window_size.y / 2
	current_speed = SPEED_ON_SPAWN
	direction = Vector2(dir, 0)

# Calculate moving and colliding
func _physics_process(delta):
	var collision = move_and_collide(direction * current_speed * delta)
	if collision:
		var collider = collision.get_collider()
		# If collided with either pad, increase speed and calculate bounce
		# angle based on pad position
		if collider == $"../LeftPad" or collider == $"../RightPad":
			current_speed += ACCELERATION
			var new_direction = new_direction(collider)
			# The new angle is 50% from the current direction and 50% from
			# where it hits the pad. This is to keep it realistic but to also
			# allow for some gameplay in trying to hit the ball with a certain
			# part of the pad.
			new_direction.y = (new_direction.y + direction.bounce(collision.get_normal()).y) / 2
			direction = new_direction
		# Otherwise we hit the top or bottom, just do simple bounce calculation
		else:
			direction = direction.bounce(collision.get_normal())
	
# This is used when the ball hits a pad.
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	# This is simply -1 if the ball is supposed to go left and 1 if right.
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	
	# Calculate the y direction based on where it hit the pad
	new_dir.y = (dist / (collider.pad_height / 2)) * MAX_BOUNCE_ANGLE
	
	# Normalize Vector2 to ensure it's the same size regardless of direction
	return new_dir.normalized()
