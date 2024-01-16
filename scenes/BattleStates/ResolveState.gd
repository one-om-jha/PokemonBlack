extends State

var player_choice: Action
var opp_choice: Action

var battle: Battle
var p: PokemonInstance
var o: PokemonInstance

var player_acted = false
var opp_acted = false

func enter_state():
	battle = get_parent().battle
	# determine move order
	
	if not player_choice is MoveAction:
		player_choice.execute(battle)
		set_player_acted()
	if not opp_choice is MoveAction:
		opp_choice.execute(battle)
		set_opp_acted()
		
	var p_move: MoveAction
	var o_move: MoveAction
	if player_choice is MoveAction:
		p_move = player_choice as MoveAction
	if opp_choice is MoveAction:
		o_move = opp_choice as MoveAction
		
	if p_move.move.priority < o_move.move.priority:
		opp_act()
		player_act()
	if p_move.move.priority > o_move.move.priority:
		player_act()
		opp_act()
	if p_move.move.priority == o_move.move.priority:
		if battle.player_party[battle.p_index].stats[5] > battle.party[battle.o_index].stats[5]:
			player_act()
			opp_act()
		else:
			opp_act()
			player_act()

func player_act():
	battle.acting = battle.player_party[battle.p_index]
	battle.affecting = battle.party[battle.o_index]
	player_choice.execute(battle)
	set_player_acted()
	
func opp_act():
	battle.acting = battle.party[battle.o_index]
	battle.affecting = battle.player_party[battle.p_index]
	opp_choice.execute(battle)
	set_opp_acted()
		
func set_player_acted():
	player_acted = true
	if player_acted and opp_acted:
		#get_parent().push_state(get_parent().choice_state)
		print("resolved!")
		
func set_opp_acted():
	opp_acted = true
	if player_acted and opp_acted:
		print("resolved!")

func exit_state():
	pass
