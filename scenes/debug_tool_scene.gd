extends Control

@onready var label = $Label

@export var pokemon: Pokemon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var dir = DirAccess.open("res://Pokemon")
	if dir:
		for filename in dir.get_files():
			var p: Pokemon = ResourceLoader.load("res://Pokemon/" + filename, "Pokemon")
			label.text = "processing " + p.name + "\n"
			var abilities_array: Array[Ability]
			abilities_array.resize(3)
			for slot in p.abilities:
				abilities_array[int(slot) - 1] = p.abilities[slot][1]
				#label.text += "new slot" + str(int(slot) - 1) + " = " + p.abilities[slot][1]
			p.abilities = abilities_array
			var res = ResourceSaver.save(p, "res://Pokemon/" + filename)


func _on_button_2_pressed():
	var p = PokemonInstance.generate_instance(pokemon, 5)
	var save = ResourceLoader.load("user://save1.tres", "PlayerData")
	save.party.resize(6)
	save.party[0] = p
	pd.data = save
	pd.save(1)
	label.text = "saved! party size: " + str(save.party.size())
