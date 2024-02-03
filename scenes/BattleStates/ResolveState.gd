extends State

var player_choice: Action
var opp_choice: Action

var battle: Battle
var p: PokemonInstance
var o: PokemonInstance

var player_acted = false
var opp_acted = false

var message_queue: Array[String]

var resolved = false

var battle_over = false

@onready var dm = $BattleDialogue
@onready var timer = $HealthTimer

@onready var opp_health_bar = %OppPanel/HPBar
@onready var opp_health_label = %OppPanel/HPLabel
@onready var player_health_bar = %PlayerPanel/HPBar
@onready var player_health_label = %PlayerPanel/HPLabel

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
		
	p_move.move_acted.connect(move_acted)
	o_move.move_acted.connect(move_acted)
		
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

func update(delta):
	if resolved:
		opp_health_label = battle.party[battle.o_index].get_health_string()
		player_health_label = battle.player_party[battle.p_index].get_health_string()
		if not timer.is_stopped():
			var opp_new = battle.party[battle.o_index].get_health_cent()
			opp_health_bar.value = opp_new + (opp_health_bar.value - opp_new) / 2
			var p_new = battle.player_party[battle.p_index].get_health_cent()
			player_health_bar.value = p_new + (player_health_bar.value - p_new) / 2

func player_act():
	battle.acting = battle.player_party[battle.p_index]
	battle.affecting = battle.party[battle.o_index]
	if player_choice.move.target == "user":
		battle.affecting = battle.player_party[battle.p_index]
	player_choice.execute(battle)
	set_player_acted()
	
func opp_act():
	battle.acting = battle.party[battle.o_index]
	battle.affecting = battle.player_party[battle.p_index]
	if opp_choice.move.target == "user":
		battle.affecting = battle.party[battle.o_index]
	opp_choice.execute(battle)
	set_opp_acted()
		
func set_player_acted():
	player_acted = true
	if player_acted and opp_acted:
		resolved_actions()
		
func set_opp_acted():
	opp_acted = true
	if player_acted and opp_acted:
		resolved_actions()

func resolved_actions():
	resolved = true
	if battle.player_party[battle.p_index].curr_health <= 0:
		player_fainted()
	if battle.party[battle.o_index].curr_health <= 0:
		opp_fainted()
	if message_queue[0].contains("used"):
		timer.start()
	dm.display(message_queue.pop_back())

func exit_state():
	message_queue.clear()
	player_acted = false
	opp_acted = false
	resolved = false

func move_acted(msg):
	message_queue.append(msg)

func _on_battle_dialogue_finished_dialogue():
	if battle_over:
		get_parent().end_battle()
	if message_queue.size() == 0:
		get_parent().push_state(get_parent().choice_state)
		return
	if message_queue.size() > 0:
		dm.display(message_queue.pop_back())

func player_fainted():
	message_queue.append("You fainted!")
	battle_over = true
	
func opp_fainted():
	message_queue.append("The opponent fainted!")
	# check if there's another party member to switch into
	if (battle.party.size() - 1) > 0:
		get_parent().opp_switch()
	else:
		message_queue.append("You won!")
		battle_over = true
	
