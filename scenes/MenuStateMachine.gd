extends StateMachine

@onready var main_state = $MainMenu
@onready var save_state = $SaveMenu
@onready var pokemon_state = $PokemonMenu

func enter_menu():
	print("entering menu")
	stack.push_front(main_state)
	main_state.enter_state()

func reset():
	if stack[0] != main_state:
		pop_state()
