extends Node

@onready var dm = $DialogueManager
@onready var anim = $AnimationPlayer
@onready var kb = $KeyboardInput
@onready var sprite = $AnimatedSprite3D
@onready var music = $Music_1

@onready var cheren = $Cheren
@onready var bianca = $Bianca
@onready var playerfriend = $PlayerFriend

@onready var world = preload("res://scenes/world.tscn")

@export var data: PlayerData

var last_displayed

var in_char_select = false
var displaying_choice = false
var selected = -1

func _ready():
	anim.play("start")
	data = PlayerData.new()
	data = PlayerData.init(data)

func _process(delta):
	if displaying_choice:
		return
		
	if in_char_select:
		if selected == -1:
			if Input.is_action_just_pressed("ui_left"):
				selected = 0
				anim.play("select_boy")
			if Input.is_action_just_pressed("ui_right"):
				selected = 1
				anim.play("select_girl")
		if selected == 0:
			if Input.is_action_just_pressed("ui_right"):
				anim.play_backwards("select_boy")
				selected = -1
			if Input.is_action_just_pressed("ui_accept"):
				anim.play("highlight_boy")
				dm.display_next()
				dm.display_choice("Yes", "No")
				displaying_choice = true
		if selected == 1:
			if Input.is_action_just_pressed("ui_left"):
				anim.play_backwards("select_girl")
				selected = -1
			if Input.is_action_just_pressed("ui_accept"):
				anim.play("highlight_girl")
				dm.display_next()
				dm.display_choice("Yes", "No")
				displaying_choice = true
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		match last_displayed:
			3:
				dm.hide_text()
				anim.play("throw_ball")
			8:
				anim.play("return_to_center")
			10:
				anim.play("show_char_select")
			14:
				dm.current_dialogue += 1
				last_displayed += 1
				kb.enter_state()
			18:
				anim.play("friends")
				dm.display_next()
			19:
				cheren.visible = true
				dm.display_next()
			20: 
				bianca.visible = true
				dm.display_next()
			21:
				playerfriend.visible = true
				dm.display_next()
			22:
				anim.play("close_friends")
				dm.display_next()
			29:
				begin_game()
			_:
				dm.display_next()

func begin_skit():
	dm.display_next()

func _on_dialogue_manager_displayed(index):
	last_displayed = index

func start_char_select():
	in_char_select = true

func _on_dialogue_manager_choice_selected(choice):
	if in_char_select:
		match choice:
			1:
				data.gender = selected
				dm.display_next()
				in_char_select = false
				displaying_choice = false
				match selected:
					0:
						playerfriend.texture.region = Rect2(486, 684, 41, 80)
					1:
						playerfriend.texture.region = Rect2(620, 684, 41, 80)
			2:
				match selected:
					0:
						anim.play_backwards("highlight_boy")
					1:
						anim.play_backwards("highlight_girl")
				dm.current_dialogue -= 1
				dm.hide_text()


func _on_keyboard_input_submitted(text):
	anim.play("RESET")
	sprite.play("default")
	data.name = text
	dm.dialogue_list[15].text += text + "?"
	dm.dialogue_list[16].text += text + "."
	dm.dialogue_list[22].text = text + "!"
	dm.display_next()


func _on_music_1_finished():
	music.play()

func begin_game():
	data.start_time = Time.get_unix_time_from_system()
	data.event_flags.finished_intro = true
	data.event_flags.opening_cutscene = false
	data.party.resize(6)
	pd.data = data
	if pd.data == data:
		anim.play("close")
	
func load_world():
	get_tree().change_scene_to_packed(world)
