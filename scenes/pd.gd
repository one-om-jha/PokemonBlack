extends Node

@export var data: PlayerData

func save(slot: int):
	var res = ResourceSaver.save(data, "user://save" + str(slot) + ".tres")
	assert (res == OK)
