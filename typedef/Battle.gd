class_name Battle extends Resource

@export var party: Array[PokemonInstance]
var player_party: Array[PokemonInstance]

var action_stack: Array[Action]
var in_progress_stack: Array[Action]

var turn = 0
