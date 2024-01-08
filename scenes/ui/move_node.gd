extends TextureButton

@export var move: Move

@onready var move_name = $Name
@onready var type = $Type
@onready var category = $Category
@onready var power = $Power
@onready var accuracy = $Accuracy
@onready var pp = $PP

func load():
	if move != null:
		var movename = move.name
		movename = movename.replace("-", " ")
		movename = movename.capitalize()
		move_name.text = movename
		if move.power == 0:
			power.text = "-"
		else:
			power.text = str(move.power)
		if move.accuracy == 0:
			accuracy.text = "-"
		else:
			accuracy.text = str(move.accuracy)
		pp.text = str(move.curr_pp) + "/" + str(move.pp)
