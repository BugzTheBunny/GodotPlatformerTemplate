extends State
class_name HitState

@export var damagable : Damagable
@export var death_state : DeathState
@export var death_animation_node : String = "death"
@export var knockback_velocity : Vector2 = Vector2(100,0)
@export var return_state : State

func _ready():
	damagable.connect("on_hit", on_hit)

func on_enter():
	await get_tree().create_timer(0.1).timeout
	next_state = return_state
	
func on_exit():
	character.velocity = Vector2.ZERO

func on_hit(node: Node, damage_amount : int,knockback_direction: Vector2):
	if damagable.health > 0:
		character.velocity = knockback_velocity * knockback_direction
		emit_signal("interrupt_state",self)
	else:
		emit_signal("interrupt_state",death_state)
		playback.travel(death_animation_node)
