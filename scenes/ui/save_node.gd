extends TextureButton

@export var save_num: String

@onready var save_title = $SaveNumber

@onready var sprite =$PlayerSprite
@onready var player_name = $TrainerName
@onready var playtime = $Playtime
@onready var badges = $Badges
@onready var pokemon = $Pokemon

func _ready():
	save_title.text = "save game " + save_num

func load_save(save: PlayerData):
	if save == null:
		return
		
	player_name.text = save.name
	
	if save.gender == 1:
		sprite.texture = ResourceLoader.load("res://textures/player/player_female.png")
	else:
		sprite.texture = ResourceLoader.load("res://textures/player/player_male.png")
		
	sprite.visible = true
	
	playtime.text = str(save.playtime)
	badges.text = str(save.badges.size())
