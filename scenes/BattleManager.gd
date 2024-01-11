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

var player_index = 0
var opp_index = 0

var battle: Battle

enum Action {
	MOVE1,
	MOVE2,
	MOVE3,
	MOVE4,
	POKEMON,
	ITEM,
	RUN,
}

var player_choice: Action
var opp_choice: Action

func start_battle():
	battle = get_parent().battle
	load_sprites()
	#stack.push_front(base_state)
	remove_child(intro_state)
	remove_child(choice_state)
	remove_child(move_state)
	remove_child(pokemon_state)
	remove_child(bag_state)
	remove_child(ai_state)
	remove_child(resolve_state)
	remove_child(end_state)
	push_state(intro_state)
	
func get_p() -> PokemonInstance:
	print_debug(pd.data.party)
	return pd.data.party[player_index]
	
func get_o() -> PokemonInstance:
	return battle.party[opp_index]

func load_sprites():
	player_sprite.sprite_frames = get_p().get_back_sprite()
	player_sprite.play("default")
	opp_sprite.sprite_frames = get_o().get_front_sprite()
	opp_sprite.play("default")
