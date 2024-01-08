extends State

@onready var anim = $"../AnimationPlayer"

var in_char_select = false

func enter_state():
	anim.play("start")
	pass
	
func exit_state():
	pass
	
func update(delta):
	pass
