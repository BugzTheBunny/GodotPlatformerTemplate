extends CharacterBody2D
class_name Player

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachineManager = $CharacterStateMachineManager

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right: bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	_handle_gravity(delta)
	_handle_animation_tree()
	_handle_facing_direction()
	_handle_movement_vector()
	move_and_slide()

func _handle_movement_vector():
	direction = Input.get_vector("left", "right","up","down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func _handle_animation_tree():
	animation_tree.set("parameters/move/blend_position",direction.x)

func _handle_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed",!sprite.flip_h)
	
func _handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
