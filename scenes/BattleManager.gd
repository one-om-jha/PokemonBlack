extends StateMachine

@onready var base_state = $BaseState
@onready var intro_state = $IntroState
@onready var ai_state = $AIState
@onready var choice_state = $ChoiceState

@onready var move_state = $MoveState
@onready var bag_state = $BagState
@onready var pokemon_state = $PokemonState

@onready var resolve_state = $ResolveState
@onready var end_state = $EndState

@onready var player_sprite = $BaseState/PlayerSprite
@onready var opp_sprite = $BaseState/EnemySprite

@onready var debug_label = $BaseState/CanvasLayer/Label

var battle: Battle

func start_battle():
	battle = get_parent().battle
	load_sprites()
	remove_child(intro_state)
	remove_child(choice_state)
	remove_child(move_state)
	remove_child(pokemon_state)
	remove_child(bag_state)
	remove_child(ai_state)
	remove_child(resolve_state)
	remove_child(end_state)
	push_state(intro_state)
	
func _process(delta):
	if stack.size() >= 1:
		stack[0].update(delta)
	debug_label.text = "state: \n" + stack[0].name
	
func get_p() -> PokemonInstance:
	return battle.player_party[battle.p_index]
	
func get_o() -> PokemonInstance:
	return battle.party[battle.o_index]

func load_sprites():
	player_sprite.sprite_frames = get_p().get_back_sprite()
	player_sprite.play("default")
	opp_sprite.sprite_frames = get_o().get_front_sprite()
	opp_sprite.play("default")
	
	var ball = $BaseState/CanvasLayer/OppPanel/BallContainer/Pokeball
	var ball_container = $BaseState/CanvasLayer/OppPanel/BallContainer
	ball_container.remove_child(ball)
	for i in range(0, battle.party.size()):
		ball_container.add_child(ball)
		
	ball = $BaseState/CanvasLayer/PlayerPanel/BallContainer/Pokeball
	ball_container = $BaseState/CanvasLayer/PlayerPanel/BallContainer
	ball_container.remove_child(ball)
	for i in range(0, pd.data.party.size()):
		ball_container.add_child(ball)
	
	$BaseState/CanvasLayer/OppPanel/NameLabel.text = get_o().name
	$BaseState/CanvasLayer/PlayerPanel/NameLabel.text = get_p().name
	$BaseState/CanvasLayer/OppPanel/HPBar.value = get_o().get_health_cent()
	$BaseState/CanvasLayer/PlayerPanel/HPBar.value = get_p().get_health_cent()
	$BaseState/CanvasLayer/OppPanel/HPLabel.text = get_o().get_health_string()
	$BaseState/CanvasLayer/PlayerPanel/HPLabel.text = get_p().get_health_string()
	$BaseState/CanvasLayer/OppPanel/LevelLabel.text = "Lv. " + str(get_o().level)
	$BaseState/CanvasLayer/PlayerPanel/LevelLabel.text = "Lv. " + str(get_p().level)
	
func opp_switch():
	battle.o_index += 1
	opp_sprite.sprite_frames = get_o().get_front_sprite()
	opp_sprite.play("default")
	$BaseState/CanvasLayer/OppPanel/NameLabel.text = get_o().name
	$BaseState/CanvasLayer/OppPanel/HPBar.value = get_o().get_health_cent()
	$BaseState/CanvasLayer/OppPanel/HPLabel.text = get_o().get_health_string()
	$BaseState/CanvasLayer/OppPanel/LevelLabel.text = "Lv. " + str(get_o().level)

func end_battle():
	get_parent().end_battle()
