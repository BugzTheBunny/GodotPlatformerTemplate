extends Area2D

@export var damage : int = 5
@export var player : Player
@export var facing_direction : FacingCollisionShape

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damagable:
			var direction_to_damagable = body.global_position - get_parent().global_position
			var direction_sign = sign(direction_to_damagable.x)
			
			if (direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)

func _on_player_facing_changed(facing_right:bool):
	if facing_right:
		facing_direction.position = facing_direction.facing_right_position
	else:
		facing_direction.position = facing_direction.facing_left_position
