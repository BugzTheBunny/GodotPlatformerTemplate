extends State
class_name GroundState

@export var air_state : AirState
@export var landing_state : LandingState
@export var jump_velocity : float = 200.0
@export var jump_animation : String = "jump_start"

func _ready():
	jump_velocity = -(jump_velocity)

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event: InputEvent):
	if (event.is_action_pressed("jump")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
