extends State

@onready var dm = $IntroDialogue

func enter_state():
	dm.display("A wild patrat appeared!")
	
func exit_state():
	pass

func _on_intro_dialogue_finished_dialogue():
	get_parent().push_state(get_parent().ai_state)
