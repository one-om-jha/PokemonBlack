extends State

@onready var fight_button = $CanvasLayer/VBoxContainer/FightButton
@onready var pokemon_button = $CanvasLayer/VBoxContainer/PokemonButton
@onready var bag_button = $CanvasLayer/VBoxContainer/BagButton
@onready var run_button = $CanvasLayer/VBoxContainer/RunButton

func enter_state():
	fight_button.visible = true
	fight_button.disabled = false
	pokemon_button.visible = true
	pokemon_button.disabled = false
	bag_button.visible = true
	bag_button.disabled = false
	run_button.visible = true
	run_button.disabled = false
	
func exit_state():
	fight_button.visible = false
	fight_button.disabled = true
	pokemon_button.visible = false
	pokemon_button.disabled = true
	bag_button.visible = false
	bag_button.disabled = true
	run_button.visible = false
	run_button.disabled = true


func _on_fight_button_pressed():
	get_parent().push_state(get_parent().move_state)

func _on_pokemon_button_pressed():
	get_parent().push_state(get_parent().pokemon_state)

func _on_bag_button_pressed():
	get_parent().push_state(get_parent().bag_state)

func _on_run_button_pressed():
	get_parent().push_state(get_parent().resolve_state)
