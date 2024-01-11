extends State

func enter_state():
	get_parent().opp_choice = get_parent().Action.MOVE1
	get_parent().push_state(get_parent().choice_state)
	
func exit_state():
	pass
