extends State

@export var battle: Battle

@onready var camera = $BattleManager/BaseState/Camera3D
@onready var bm = $BattleManager

func enter_state():
	camera.current = true
	battle.player_party = pd.data.party
	bm.start_battle()
	
func exit_state():
	pass

func end_battle():
	get_parent().pop_state()
