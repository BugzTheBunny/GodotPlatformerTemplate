extends State
class_name AirState

@export var landing_state : LandingState
@export var landing_animation : String = "jump_end" 
@export var double_jump_velocity : float = 250
@export var double_jump_animation : String = "double_jump"

var has_double_jumped = false

func _ready():
	double_jump_velocity = -(double_jump_velocity)

func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state

func state_input(event:InputEvent):
	if event.is_action_pressed("jump") && !has_double_jumped:
		_double_jump()

func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
		has_double_jumped = false

func _double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true
