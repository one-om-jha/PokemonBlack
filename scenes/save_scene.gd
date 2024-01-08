extends CanvasLayer

var world_scene = preload("res://scenes/world.tscn")
var start_scene = preload("res://scenes/start_scene.tscn")

@onready var Save1 = $Save1
@onready var Save2 = $Save2
@onready var Save3 = $Save3

@onready var anim = $AnimationPlayer

var save_1
var save_2
var save_3

var selected_save = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Save1.grab_focus()
	load_saves()
	
func load_saves():
	save_1 = ResourceLoader.load("user://save1.tres", "PlayerData")
	save_2 = ResourceLoader.load("user://save2.tres", "PlayerData")
	save_3 = ResourceLoader.load("user://save3.tres", "PlayerData")
	
	if save_1 != null:
		Save1.load_save(save_1)
		
	if save_2 != null:
		Save2.load_save(save_2)
		
	if save_2 != null:
		Save3.load_save(save_3)

func _on_save_1_pressed():
	anim.play("begin_game")

func _on_save_2_pressed():
	anim.play("begin_game")

func _on_save_3_pressed():
	anim.play("begin_game")
	
func begin_game():
	match selected_save:
		1:
			save_1_load()
		2:
			save_2_load()
		3:
			save_3_load()
		_:
			pass

func save_1_load():
	if save_1 != null:
		pd.data = save_1
		get_tree().change_scene_to_packed(world_scene)
	else:
		get_tree().change_scene_to_packed(start_scene)

func save_2_load():
	if save_2 != null:
		pd.data = save_2
		get_tree().change_scene_to_packed(world_scene)
	else:
		get_tree().change_scene_to_packed(start_scene)
		
func save_3_load():
	if save_3 != null:
		pd.data = save_3
		get_tree().change_scene_to_packed(world_scene)
	else:
		get_tree().change_scene_to_packed(start_scene)
