extends State

@onready var p_move_1 = $CanvasLayer/Move1
@onready var p_move_2 = $CanvasLayer/Move2
@onready var p_move_3 = $CanvasLayer/Move3
@onready var p_move_4 = $CanvasLayer/Move4

@export var p: PokemonInstance

func enter_state():
	p = get_parent().get_p()
	if p.move1 != null:
		p_move_1.move = p.move1
		p_move_1.load()
	else:
		p_move_1.disabled = true
		p_move_1.visible = false
		
	if p.move2 != null:
		p_move_2.move = p.move2
		p_move_2.load()
	else:
		p_move_2.disabled = true
		p_move_2.visible = false
	if p.move3 != null:
		p_move_3.move = p.move3
		p_move_3.load()
	else:
		p_move_3.disabled = true
		p_move_3.visible = false
		
	if p.move4 != null:
		p_move_4.move = p.move4
		p_move_4.load()
	else:
		p_move_4.disabled = true
		p_move_4.visible = false
	
func exit_state():
	p_move_1.visible = false
	p_move_1.disabled = true
	p_move_2.visible = false
	p_move_2.disabled = true
	p_move_3.visible = false
	p_move_3.disabled = true
	p_move_4.visible = false
	p_move_4.disabled = true


func _on_move_1_pressed():
	get_parent().player_choice = get_parent().Action.MOVE1
	get_parent().push_state(get_parent().resolve_state)

func _on_move_2_pressed():
	get_parent().player_choice = get_parent().Action.MOVE2
	get_parent().push_state(get_parent().resolve_state)

func _on_move_3_pressed():
	get_parent().player_choice = get_parent().Action.MOVE3
	get_parent().push_state(get_parent().resolve_state)

func _on_move_4_pressed():
	get_parent().player_choice = get_parent().Action.MOVE4
	get_parent().push_state(get_parent().resolve_state)
