extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float = -250.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = true

var direction : Vector2 = Vector2.ZERO

func _ready():
	animated_sprite.animation_finished.connect(on_animation_finished)

func _physics_process(delta):
	_handle_jump(delta)
	_handle_movement_vector()
	_handle_facing_direction()
	_handle_movement_animation()
	move_and_slide()

func _handle_movement_vector():
	direction = Input.get_vector("left", "right","up","down")
	if direction.x != 0 && animated_sprite.animation != "jump_end":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func _handle_jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		if was_in_air == true:
			_land()
		
		was_in_air = false
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			_normal_jump()
		elif not has_double_jumped:
			_double_jump()

func _normal_jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true

func _double_jump():
	velocity.y = double_jump_velocity
	animated_sprite.play("jump_start")
	has_double_jumped = true

func _handle_movement_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")
		

func _handle_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

func _land():
	animated_sprite.play("jump_end")
	animation_locked = true

func on_animation_finished():
	if animated_sprite.animation == "jump_end":
		animation_locked = false
