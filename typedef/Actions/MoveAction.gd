class_name MoveAction extends Action

@export var move: Move

func execute(battle: Battle):
	var acc = randi_range(0,100)
	if acc > move.accuracy:
		return
	
	if move.power != 0:
		var damage = damage(move, battle)
		
	if move.ailment != null:
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
	for type in battle.acting.types:
		if Type.Type.get(type) == move.type:
			stab = 1.5
	var type = 1.0
	for e_type in battle.affecting.types:
		type *= Type.rel[move.type][e_type]
	damage = damage * weather * stab * type
	damage = damage * (randi_range(85,100) / 100)
	battle.affecting.mod_health(-damage)
	return damage
	
func ailment(move, battle):
	battle.affecting.ailments.push_front(move.ailment)

func stat_change(move, battle):
	battle.affecting.stat_changes.resize(6)
	for change in move.stat_changes:
		match change["stat"]["name"]:
			"attack":
				battle.affecting.stat_changes[1] += change["change"]
			"defense":
				battle.affecting.stat_changes[2] += change["change"]
			"special-attack":
				battle.affecting.stat_changes[3] += change["change"]
			"special-defense":
				battle.affecting.stat_changes[4] += change["change"]
			"speed":
				battle.affecting.stat_changes[5] += change["change"]
			_:
				battle.affecting.stat_changes[0] += change["change"]
				
func heal(move, battle):
	battle.affecting.mod_health(move.healing)

func drain(move, battle, damage):
	battle.acting.mod_health(damage * (move.drain / 100))
	
func ohko(move, battle):
	battle.affecting.mod_health(500000)
	
func weather(move, battle):
	battle.weather = move.name
	
func field(move, battle):
	battle.player_field = move.name
