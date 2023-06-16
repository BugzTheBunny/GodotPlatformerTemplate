extends Node
class_name Damagable

signal on_hit(node: Node, damage_taken : int, knockback_direction: Vector2)

@export var health : float = 20

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func hit(damage: int, knockback_direction: Vector2):
	health -= damage
	SignalBus.on_health_changed(get_parent(),damage)
	emit_signal("on_hit",get_parent(), damage, knockback_direction)

func heal(amount:int):
	pass 
