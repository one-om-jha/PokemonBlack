class_name Battle extends Resource

@export var party: Array[PokemonInstance]
var player_party: Array[PokemonInstance]

var action_stack: Array[Action]
var in_progress_stack: Array[Action]

var turn = 0

var acting: PokemonInstance
var affecting: PokemonInstance

var p_index = 0
var o_index = 0

var weather = "normal"

var player_field = "normal"
var opp_field = "normal"
