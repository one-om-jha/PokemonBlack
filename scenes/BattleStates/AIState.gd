extends State

@onready var resolve_state = $"../ResolveState"

func enter_state():
	#get_parent().opp_choice = get_parent().Action.MOVE1
	var action = MoveAction.new()
	action.move = get_parent().get_o().move1
	resolve_state.opp_choice = action
	get_parent().push_state(get_parent().choice_state)
	
func exit_state():
	pass
