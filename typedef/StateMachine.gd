class_name StateMachine extends Node

var stack: Array = []

func push_state(state: State):
	stack[0].exit_state()
	remove_child(stack[0])
	add_child(state)
	stack.push_front(state)
	state.enter_state()
	
func pop_state():
	var child = stack.pop_front()
	child.exit_state()
	remove_child(child)
	add_child(stack[0])
	stack[0].enter_state()
	
func _process(delta):
	if stack.size() >= 1:
		stack[0].update(delta)
	
func _physics_process(delta):
	if stack.size() >= 1:
		stack[0].physics_update(delta)
	
func _input(event):
	if stack.size() >= 1:
		stack[0].input(event)
