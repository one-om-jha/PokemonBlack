extends Button

@export var p: PokemonInstance

@onready var sprite = $Sprite
@onready var p_name = $Name
@onready var xp_bar = $XPBar
@onready var xp_label = $XPLabel
@onready var health_bar = $HealthBar
@onready var health_label = $HealthLabel
@onready var level = $Level

func load():
	if p != null:
		sprite.texture = p.get_default_sprite()
		p_name.text = p.name
		health_bar.value = float(p.curr_health) / float(p.stats[0])
		health_label.text = str(p.curr_health) + "/" + str(p.stats[0])
		xp_bar.value = float(p.get_curr_xp()) - float(p.get_next_xp())
		xp_label.text = str(p.get_curr_xp()) + "/" + str(p.get_next_xp())
		level.text = str(p.level)
