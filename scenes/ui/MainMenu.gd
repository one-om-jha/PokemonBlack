extends State

@onready var pokemon_button = $MenuButtons/PokemonButton
@onready var anim = $AnimationPlayer

func enter_state():
	pokemon_button.grab_focus()
	anim.play("open")
	
	for child in $MenuButtons.get_children():
		child.disabled = false
		
func exit_state():
	anim.play("close")
	for child in $MenuButtons.get_children():
		child.disabled = true

func _on_pokemon_button_pressed():
	get_parent().push_state(get_parent().pokemon_state)

func _on_dex_button_pressed():
	pass # Replace with function body.

func _on_bag_button_pressed():
	pass # Replace with function body.

func _on_trainer_button_pressed():
	pass # Replace with function body.

func _on_save_button_pressed():
	get_parent().push_state(get_parent().save_state)

func _on_options_button_pressed():
	pass # Replace with function body.
