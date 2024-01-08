extends State

@onready var sm = $MenuStateMachine

func enter_state():
	sm.enter_menu()

func update(delta):
	if Input.is_action_just_pressed("menu"):
		sm.reset()
		get_parent().pop_state()
