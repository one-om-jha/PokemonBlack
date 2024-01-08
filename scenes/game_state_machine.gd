extends StateMachine

@onready var overworld_state = $OverworldState
@onready var menu_state = $MenuState
@onready var battle_state = $BattleState



func _ready():
	remove_child(menu_state)
	remove_child(battle_state)
	stack.push_front(overworld_state)
	overworld_state.enter_state()

func init_battle(battle: Battle):
	battle_state.battle = battle
	push_state(battle_state)

func end_battle():
	pop_state()
