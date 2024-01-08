class_name PlayerData extends Resource

# Trainer Info
@export var name: String
@export var gender: int
@export var badges: Dictionary
@export var playtime: int
@export var start_time: int
@export var hall_of_fame_time: int
@export var map: String
@export var map_pos: Vector3

# Pokedex
@export var pokedex: Array[DexEntry]

# Inventory
@export var inventory: Array[Item]

# Event Flags
@export var event_flags: EventFlags

# Pokemon - Party
@export var party: Array[PokemonInstance]

# Pokemon - Boxes
@export var pc: Array[Box]

# Options
@export var options: PlayerOptions

static func init(data: PlayerData) -> PlayerData:
	data.pokedex = []
	data.inventory = []
	data.event_flags = EventFlags.new()
	data.party = []
	data.pc = []
	data.options = PlayerOptions.new()
	return data
