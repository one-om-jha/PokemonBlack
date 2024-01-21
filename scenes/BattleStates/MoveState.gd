extends State

@onready var p_move_1 = $CanvasLayer/Move1
@onready var p_move_2 = $CanvasLayer/Move2
@onready var p_move_3 = $CanvasLayer/Move3
@onready var p_move_4 = $CanvasLayer/Move4

@onready var resolve_state = $"../ResolveState"

@export var p: PokemonInstance

func enter_state():
	p_move_1.visible = true
	p_move_2.visible = true
	p_move_3.visible = true
	p_move_4.visible = true
	p_move_1.disabled = false
	p_move_2.disabled = false
	p_move_3.disabled = false
	p_move_4.disabled = false
	
	p_move_1.grab_focus()
	p = get_parent().get_p()
	if p.move1 != null:
		p_move_1.move = p.move1
		p_move_1.load()
	else:
		p_move_1.disabled = true
		
	if p.move2 != null:
		p_move_2.move = p.move2
		p_move_2.load()
	else:
		p_move_2.disabled = true
	if p.move3 != null:
		p_move_3.move = p.move3
		p_move_3.load()
	else:
		p_move_3.disabled = true
		
	if p.move4 != null:
		p_move_4.move = p.move4
		p_move_4.load()
	else:
		p_move_4.disabled = true
	
func exit_state():
	p_move_1.visible = false
	p_move_1.disabled = true
	p_move_2.visible = false
	p_move_2.disabled = true
	p_move_3.visible = false
	p_move_3.disabled = true
	p_move_4.visible = false
	p_move_4.disabled = true

func update(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().push_state(get_parent().choice_state)

func _on_move_1_pressed():
	var action = MoveAction.new()
	action.move = p.move1
	resolve_state.player_choice = action
	get_parent().push_state(resolve_state)

func _on_move_2_pressed():
	var action = MoveAction.new()
	action.move = p.move2
	resolve_state.player_choice = action
	get_parent().push_state(resolve_state)

func _on_move_3_pressed():
	var action = MoveAction.new()
	action.move = p.move3
	resolve_state.player_choice = action
	get_parent().push_state(resolve_state)

func _on_move_4_pressed():
	var action = MoveAction.new()
	action.move = p.move4
	resolve_state.player_choice = action
	get_parent().push_state(resolve_state)
