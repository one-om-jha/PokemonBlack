class_name MoveAction extends Action

@export var move: Move

signal move_acted(msg)

var message: String

func execute(battle: Battle):
	message = battle.acting.name.capitalize() + " used " + move.name.capitalize() + "!"
	
	var acc = randi_range(0,100)
	if acc > move.accuracy:
		message += "\nBut it failed!"
		move_acted.emit(message)
		return
	
	if move.power != 0:
		var damage = damage(move, battle)
		
	if move.ailment != null and move.ailment.name != "none":
		ailment(move, battle)
		
	if move.stat_changes.size() > 0:
		stat_change(move, battle)

	if move.healing != 0:
		heal(move, battle)
		
	if move.drain != 0:
		drain(move, battle, damage)
		
	if move.category == "ohko":
		ohko(move, battle)
		
	if move.category == "whole-field-effect":
		weather(move, battle)

	if move.category == "field-effect":
		field(move, battle)
		
	if move.category == "unique":
		return
		
	move_acted.emit(message)

func damage(move, battle) -> float:
	var crit = randi_range(1,24) == 1
	if crit:
		crit = 1.5
	else:
		crit = 1.0
	var atk = battle.acting.get_effective_stat(1)
	var def = battle.affecting.get_effective_stat(2)
	if move.damage_class == "special":
		atk = battle.acting.get_effective_stat(3)
		def = battle.acting.get_effective_stat(4)
	var damage = ((((2*battle.acting.level)/5)+2)*move.power*(atk/def))/50
	damage = damage * battle.acting.get_item_mult() * crit + 2
	var weather = 1.0
	var stab = 1.0
	for type in battle.acting.pokemon.types:
		if Type.Type.get(type) == move.type:
			stab = 1.5
	var type = 1.0
	for e_type in battle.affecting.pokemon.types:
		type *= Type.rel[move.type][e_type]
	if type == 2.0:
		message += "\nIt was supereffective!"
	if type == 0.5:
		message += "\nIt wasn't very effective..."
	damage = damage * weather * stab * type
	var rand = randf_range(85,100) / 100.0
	damage = damage * (rand)
	battle.affecting.mod_health(-damage)
	return damage
	
func ailment(move, battle):
	battle.affecting.ailments.push_front(move.ailment)
	message += "\n" + battle.affecting.name.capitalize() + " was " + move.ailment.name.capitalize() + "d!"

func stat_change(move, battle):
	battle.affecting.stat_changes.resize(6)
	for change in move.stat_changes:
		match change["stat"]["name"]:
			"attack":
				battle.affecting.stat_changes[1] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s Attack was "
				if change["change"] == 1:
					message += "raised!"
				if change["change"] >= 2:
					message += "sharply raised!"
				if change["change"] == -1:
					message += "lowered!"
				if change["change"] <= -2:
					message += "harshly lowered!"
			"defense":
				battle.affecting.stat_changes[2] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s Defense was "
				if change["change"] == 1:
					message += "raised!"
				if change["change"] >= 2:
					message += "sharply raised!"
				if change["change"] == -1:
					message += "lowered!"
				if change["change"] <= -2:
					message += "harshly lowered!"
			"special-attack":
				battle.affecting.stat_changes[3] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s Special Attack was "
				if change["change"] == 1:
					message += "raised!"
				if change["change"] >= 2:
					message += "sharply raised!"
				if change["change"] == -1:
					message += "lowered!"
				if change["change"] <= -2:
					message += "harshly lowered!"
			"special-defense":
				battle.affecting.stat_changes[4] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s Special Defense was "
				if change["change"] == 1:
					message += "raised!"
				if change["change"] >= 2:
					message += "sharply raised!"
				if change["change"] == -1:
					message += "lowered!"
				if change["change"] <= -2:
					message += "harshly lowered!"
			"speed":
				battle.affecting.stat_changes[5] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s Speed was "
				if change["change"] == 1:
					message += "raised!"
				if change["change"] >= 2:
					message += "sharply raised!"
				if change["change"] == -1:
					message += "lowered!"
				if change["change"] <= -2:
					message += "harshly lowered!"
			_:
				battle.affecting.stat_changes[0] += change["change"]
				message += "\n" + battle.affecting.name.capitalize() + "'s "
				if change["change"] == 1:
					message += "Evasion was raised!"
				if change["change"] >= 2:
					message += "Evasion was sharply raised!"
				if change["change"] == -1:
					message += "Accuracy was lowered!"
				if change["change"] <= -2:
					message += "Accuracy harshly lowered!"
	
func heal(move, battle):
	battle.affecting.mod_health(move.healing)
	message += "\n" + battle.affecting.name.capitalize() + " restored some health!"

func drain(move, battle, damage):
	battle.acting.mod_health(damage * (move.drain / 100))
	message += "\n " + battle.affecting.name.capitalize() + "'s health was drained!"
	
func ohko(move, battle):
	battle.affecting.mod_health(500000)
	
func weather(move, battle):
	battle.weather = move.name
	message += "\nWeather changed to " + move.name.capitalize()
	
func field(move, battle):
	battle.player_field = move.name
