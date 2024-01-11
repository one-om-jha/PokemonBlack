class_name PokemonInstance extends Resource

@export var name: String
@export var pokemon: Pokemon

@export var curr_health: int
@export var ivs: Array[int]
@export var evs: Array[int]
@export var stats: Array[int]
@export var xp: int
@export var level: int
@export var ball: String
@export var held_item: Item
@export var ability_slot: int
@export var nature: Nature
@export var gender: int
@export var ailments: Array[Ailment]

@export var shiny: bool

@export var move1: Move
@export var move2: Move
@export var move3: Move
@export var move4: Move

@export var met_location: String
@export var met_time: int
@export var markings: Array
@export var original_trainer: String

func get_sprite(type: String) -> SpriteFrames:
	return ResourceLoader.load(pokemon.sprites[type], "SpriteFrames")
	
func get_back_sprite() -> SpriteFrames:
	var type = "back"
	if shiny:
		type += "_shiny"
	if pokemon.species.has_gender_differences:
		if gender == 1:
			type += "_female"
	if type == "back":
		type += "_default"
	return ResourceLoader.load(pokemon.sprites[type], "SpriteFrames")
	
func get_front_sprite() -> SpriteFrames:
	var type = "front"
	if shiny:
		type += "_shiny"
	if pokemon.species.has_gender_differences:
		if gender == 1:
			type += "_female"
	if type == "front":
		type += "_default"
	return ResourceLoader.load(pokemon.sprites[type], "SpriteFrames")

func get_curr_xp() -> int:
	return xp - pokemon.species.growth_rate.levels[float(level)]
	
func get_next_xp() -> int:
	return pokemon.species.growth_rate.levels[float(level + 1)] - xp
	
func update_level():
	level = pokemon.species.growth_rate.values().bsearch(xp)
	
func load_stats():
	stats.resize(6)
	var hp: int = floor(((2 * pokemon.stats["hp"] + ivs[0] + floor(evs[0]/4)) * level) / 100) + level + 10
	var attack: int = (floor(((2 * pokemon.stats["attack"] + ivs[1] + floor(evs[1]/4)) * level) / 100) + 5)
	var defense: int = (floor(((2 * pokemon.stats["defense"] + ivs[2] + floor(evs[2]/4)) * level) / 100) + 5)
	var spatk: int = (floor(((2 * pokemon.stats["special-attack"] + ivs[3] + floor(evs[3]/4)) * level) / 100) + 5)
	var spdef: int = (floor(((2 * pokemon.stats["special-defense"] + ivs[4] + floor(evs[4]/4)) * level) / 100) + 5)
	var speed: int = (floor(((2 * pokemon.stats["speed"] + ivs[5] + floor(evs[5]/4)) * level) / 100) + 5)
	
	match nature.increased_stat:
		"attack":
			attack = floor(attack * 1.1)
		"defense":
			defense = floor(attack * 1.1)
		"special-attack":
			spatk = floor(spatk * 1.1)
		"special-defense":
			spdef = floor(spdef * 1.1)
		"speed":
			speed = floor(speed * 1.1)
			
	match nature.decreased_stat:
		"attack":
			attack = floor(attack * 0.9)
		"defense":
			defense = floor(defense * 0.9)
		"special-attack":
			spatk = floor(spatk * 0.9)
		"special-defense":
			spdef = floor(spdef * 0.9)
		"speed":
			speed = floor(speed * 0.9)
			
	stats[0] = hp
	stats[1] = attack
	stats[2] = defense
	stats[3] = spatk
	stats[4] = spdef
	stats[5] = speed


static func generate_instance(pokemon, level) -> PokemonInstance:
	var p = PokemonInstance.new()
	p.name = pokemon.name
	p.pokemon = pokemon
	
	for i in range(0,6):
		p.ivs.append(randi_range(0,31))
		p.evs.append(0)
	
	p.xp = pokemon.species.growth_rate.levels[float(level)]
	p.level = level
	
	p.ball = ""
	
	for item in pokemon.held_items:
		if randi_range(0,100) < item[1]:
			p.held_item = item[0]
	
	p.ability_slot = randi_range(1,2)
	
	p.nature = Nature.get_random_nature()
	
	if pokemon.species.gender_rate == -1:
		p.gender = -1
	else:
		if randf() < (float(pokemon.species.gender_rate) / float(8)):
			p.gender = 1
		else:
			p.gender = 0
			
	print_debug(pokemon.moves[0][1])
	
	var level_moves: Array
	for move in pokemon.moves:
		if move[1] == "level-up" and move[0] <= level:
			level_moves.append(move)
	print_debug(level_moves)
	level_moves.sort_custom(func(a,b): a[0] < b[0])
	level_moves = level_moves.map(func(move): return move[2])
	
	p.move1 = level_moves.pop_back()
	p.move2 = level_moves.pop_back()
	p.move4 = level_moves.pop_back()
	p.move3 = level_moves.pop_back()
	
	p.met_location = ""
	p.met_time = ""
	p.original_trainer = ""
	
	p.load_stats()
	p.curr_health = p.stats[0]
	
	return p
