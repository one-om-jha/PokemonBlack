extends Node

@export var encounters: Array[Encounter]

var battled = false

signal trigger_battle(battle: Battle)

func _on_body_entered(body):
	if battled:
		return
		
	if body.name == "Player":
		# trigger battle
		var battle = Battle.new()
		
		var i = 0
		while !encounters[i].chance():
			i += 1
			if i >= encounters.size():
				i = 0
		
		battle.party.append(encounters[i].create_instance())
		trigger_battle.emit(battle)
		battled = true
