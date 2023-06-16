extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

@export var starting_move_direction: Vector2 = Vector2.LEFT
@export var move_speed : float = 25.0
@export var hit_state : State

@onready var state_machine : CharacterStateMachineManager = $StateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction : Vector2 = starting_move_direction
	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * move_speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	move_and_slide()
