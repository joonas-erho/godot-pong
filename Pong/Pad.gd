extends StaticBody2D

# The export decorator allows for these values to be edited in the inspector.
# Thus we can have different values for the Left and Right pad.
# The up and down keys are the human controls, defined in the Project settings.
# can_be_cpu is true for the right pad, as it can be a CPU.
@export var up_key: StringName
@export var down_key: StringName
@export var can_be_cpu: bool

var scene_height: int
var pad_height: int

func _ready():
	scene_height = get_viewport_rect().size.y
	pad_height = $ColorRect.get_size().y

func _process(delta):
	# If it's multiplayer (or if this is the left pad i.e. can't be CPU),
	# listen to key presses to move the pad.
	if $"/root/GlobalData".is_multiplayer or !can_be_cpu:
		if Input.is_action_pressed(up_key):
			position.y -= get_parent().PAD_SPEED * delta
		elif Input.is_action_pressed(down_key):
			position.y += get_parent().PAD_SPEED * delta

	# Clamp the position so that the pad can't escape the screen.
	position.y = clamp(position.y, pad_height / 2, scene_height - pad_height / 2)
