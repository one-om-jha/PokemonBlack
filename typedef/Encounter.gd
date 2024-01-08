class_name Encounter extends Resource

@export var pokemon: Pokemon
@export var low_level: int
@export var high_level: int
@export var appearance_chance: int

func get_level() -> int:
	return randi_range(low_level, high_level)
	
func chance() -> bool:
	return randi_range(0,100) < appearance_chance
	
func create_instance() -> PokemonInstance:
	return PokemonInstance.generate_instance(pokemon, get_level())
