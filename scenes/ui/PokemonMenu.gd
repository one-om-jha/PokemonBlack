extends State

@onready var party = $Party
@onready var moves = $Details/Moves
@onready var stats = $Details/Stats

@onready var party_anim = $PartyAnimPlayer
@onready var anim = $AnimationPlayer

@onready var pokemon_1 = $Party/Pokemon1

# details
@onready var p_sprite = $Details/Sprite
@onready var p_name = $Details/Name
@onready var p_ability_name = $Details/AbilityName
@onready var p_ability_desc = $Details/AbilityDetails
@onready var p_item_name = $Details/ItemName
@onready var p_item_sprite = $Details/ItemSprite
@onready var p_item_details = $Details/ItemDetails
@onready var p_nature = $Details/Nature
@onready var p_gender = $Details/Gender
@onready var p_summary = $Details/Summary
@onready var p_height = $Details/Height
@onready var p_weight = $Details/Weight
@onready var p_ot = $Details/OT
@onready var p_move_1 = $Details/Moves/Move1
@onready var p_move_2 = $Details/Moves/Move2
@onready var p_move_3 = $Details/Moves/Move3
@onready var p_move_4 = $Details/Moves/Move4
@onready var p_hpbar = $Details/Stats/HPBar
@onready var p_atkbar = $Details/Stats/AtkBar
@onready var p_defbar = $Details/Stats/DefBar
@onready var p_spatkbar = $Details/Stats/SpatkBar
@onready var p_spdefbar = $Details/Stats/SpdefBar
@onready var p_spdbar = $Details/Stats/SpdBar
@onready var p_ivs = $Details/Stats/IVs
@onready var p_evs = $Details/Stats/EVs
@onready var p_stats = $Details/Stats/Stats

var selected_index = 0

func enter_state():
	anim.play("open")
	pokemon_1.grab_focus()
	for child in party.get_children():
		child.disabled = false
	for child in moves.get_children():
		child.disabled = false
	load_party()
	update_details()
		
func exit_state():
	anim.play("close")
	for child in party.get_children():
		child.disabled = true
	for child in moves.get_children():
		child.disabled = true

func update_details():
	var p = pd.data.party[selected_index]
	p_sprite.sprite_frames = p.get_front_sprite()
	p_sprite.play("default")
	p_name.text = p.name
	p_ability_name.text = p.pokemon.abilities[p.ability_slot].name
	p_ability_desc.text = p.pokemon.abilities[p.ability_slot].effect
	if p.held_item != null:
		p_item_name.text = p.held_item.name.replace("-", " ")
		var image = Image.load_from_file(p.held_item.sprite)
		var tex = ImageTexture.create_from_image(image)
		p_item_sprite.texture = tex
		p_item_details.text = p.held_item.flavor
	p_nature.text = p.nature.name
	match p.gender:
		-1:
			p_gender.text = "none"
		0:
			p_gender.text = "male"
		1:
			p_gender.text = "female"
	p_summary.text = "We first met one another on 12/31/2023, and it was on Route 1!\nAt the time, this Pokémon was Lv. 4.\n\nThis Pokémon likes to nod off."
	p_height.text = str(p.pokemon.height)
	p_weight.text = str(p.pokemon.weight)
	p_ot.text = p.original_trainer
	
	if p.move1 != null:
		p_move_1.move = p.move1
		p_move_1.load()
	else:
		p_move_1.disabled = true
		p_move_1.visible = false
		
	if p.move2 != null:
		p_move_2.move = p.move2
		p_move_2.load()
	else:
		p_move_2.disabled = true
		p_move_2.visible = false
		
	if p.move3 != null:
		p_move_3.move = p.move3
		p_move_3.load()
	else:
		p_move_3.disabled = true
		p_move_3.visible = false
		
	if p.move4 != null:
		p_move_4.move = p.move4
		p_move_4.load()
	else:
		p_move_4.disabled = true
		p_move_4.visible = false
		
	var total_stats = 0
	for stat in p.stats:
		total_stats += stat
	p_hpbar.value = p.stats[0] / total_stats
	p_atkbar.value = p.stats[1] / total_stats
	p_defbar.value = p.stats[2] / total_stats
	p_spatkbar.value = p.stats[3] / total_stats
	p_spdefbar.value = p.stats[4] / total_stats
	p_spdbar.value = p.stats[5] / total_stats
	
	var ivs = ""
	for iv in p.ivs:
		ivs += str(iv)
		ivs += "\n"
	
	var evs = ""
	for ev in p.evs:
		evs += str(ev)
		evs += "\n"
	
	var stats = ""
	for stat in p.stats:
		stats += str(stat)
		stats += "\n"
		
	p_ivs.text = ivs
	p_evs.text = evs
	p_stats.text = stats
	
func load_party():
	for i in range(0,6):
		print_debug(pd.data.party)
		if pd.data.party[i] != null:
			party.get_children()[i].p = pd.data.party[i]
			party.get_children()[i].load()
		else:
			party.get_children()[i].disabled = true
			party.get_children()[i].visible = false

func _on_pokemon_1_pressed():
	selected_index = 0
	update_details()

func _on_pokemon_2_pressed():
	selected_index = 1
	update_details()

func _on_pokemon_3_pressed():
	selected_index = 2
	update_details()

func _on_pokemon_4_pressed():
	selected_index = 3
	update_details()

func _on_pokemon_5_pressed():
	selected_index = 4
	update_details()

func _on_pokemon_6_pressed():
	selected_index = 5
	update_details()

func _on_pokemon_1_focus_entered():
	party_anim.play("select_1")


func _on_pokemon_2_focus_entered():
	party_anim.play("select_2")


func _on_pokemon_3_focus_entered():
	party_anim.play("select_3")


func _on_pokemon_4_focus_entered():
	party_anim.play("select_4")


func _on_pokemon_5_focus_entered():
	party_anim.play("select_5")


func _on_pokemon_6_focus_entered():
	party_anim.play("select_6")
