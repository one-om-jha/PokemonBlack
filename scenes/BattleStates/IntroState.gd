extends State

@onready var dm = $IntroDialogue

var finished_text = false

func enter_state():
	dm.display("A wild patrat appeared!")
	
func exit_state():
	pass

func update(delta):
	if finished_text or Input.is_action_just_pressed("ui_accept"):
		get_parent().push_state(get_parent().ai_state)

func _on_intro_dialogue_finished_dialogue():
	finished_text = true
