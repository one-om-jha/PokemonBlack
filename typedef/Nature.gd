class_name Nature extends Resource

@export var id: int
@export var name: String
@export var decreased_stat: String
@export var increased_stat: String
@export var hates_flavor: String
@export var likes_flavor: String

static var natures = [
	"adamant",
	"bashful",
	"bold",
	"brave",
	"calm",
	"careful",
	"docile",
	"gentle",
	"hardy",
	"hasty",
	"impish",
	"jolly",
	"lax",
	"lonely",
	"mild",
	"modest",
	"naive",
	"naughty",
	"quiet",
	"quirky",
	"rash",
	"relaxed",
	"sassy",
	"serious",
	"timid"
]

static func get_random_nature() -> Nature:
	var num = randi_range(0,24)
	var nat = natures[num]
	var nature = ResourceLoader.load("res://Natures/" + nat + ".tres", "Nature")
	return nature
