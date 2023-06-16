extends Node
class_name State

signal interrupt_state(new_state:State)

@export var can_move : bool = true

# Refference to the player
var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

# Handles the input of a state
func state_input(event: InputEvent):
	pass

# During process of state
func state_process(delta):
	pass

# On enter to state
func on_enter():
	pass

# On exit from state
func on_exit():
	pass
