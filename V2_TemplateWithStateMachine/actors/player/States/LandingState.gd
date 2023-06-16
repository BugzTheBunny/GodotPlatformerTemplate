extends State
class_name LandingState

@export var ground_state : GroundState
@export var landing_animation : String = "jump_end"

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animation:
		next_state = ground_state
