extends State

@export var battle: Battle

@onready var camera = $Camera3D

func enter_state():
	camera.current = true
	
func exit_state():
	pass
	
func update(delta):
	pass
