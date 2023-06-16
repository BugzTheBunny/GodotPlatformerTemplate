extends Node
class_name CharacterStateMachineManager

var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var states : Array[State]

func _ready():
	character = get_parent() as CharacterBody2D
	setup_states()

func _physics_process(delta):
	if (current_state.next_state != null):
		switch_state(current_state.next_state)
	
	current_state.state_process(delta)
	
func check_if_can_move():
	return current_state.can_move

func setup_states():
	for child in get_children():
		print(child.name)
		if (child is State):
			states.append(child)
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			
			# Connect to interrupt signal
			child.connect("interrupt_state", on_interupt_state)
		else:
			push_warning("Child" + child.name + "Is not a State") 

func switch_state(next_state:State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = next_state
	
	current_state.on_enter()

func _input(event:InputEvent):
	current_state.state_input(event)

func on_interupt_state(new_state : State):
	switch_state(new_state)
