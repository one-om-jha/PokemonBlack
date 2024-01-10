extends Control

@onready var label = $Label

@export var pokemon: Pokemon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var dir = DirAccess.open("res://Pokemon")
	if dir:
		for filename in dir.get_files():
			var p: Pokemon = ResourceLoader.load("res://Pokemon/" + filename, "Pokemon")
			label.text = "processing " + p.name + "\n"
			var abilities_array: Array[Ability]
			abilities_array.resize(3)
			for slot in p.abilities:
				abilities_array[int(slot) - 1] = p.abilities[slot][1]
				#label.text += "new slot" + str(int(slot) - 1) + " = " + p.abilities[slot][1]
			p.abilities = abilities_array
			var res = ResourceSaver.save(p, "res://Pokemon/" + filename)


func _on_button_2_pressed():
	var p = PokemonInstance.generate_instance(pokemon, 5)
	var save = ResourceLoader.load("user://save1.tres", "PlayerData")
	save.party.resize(6)
	save.party[0] = p
	pd.data = save
	pd.save(1)
	label.text = "saved! party size: " + str(save.party.size())


func _on_button_3_pressed():
	var paths = ["res://sprites/pokemon/animated", "res://sprites/pokemon/animated/female", "res://sprites/pokemon/animated/shiny", "res://sprites/pokemon/animated/shiny/female", "res://sprites/pokemon/animated/back", "res://sprites/pokemon/animated/back/female", "res://sprites/pokemon/animated/back/shiny", "res://sprites/pokemon/animated/back/shiny/female"]
	for path in paths:
		set_sprites(path)
	
func set_sprites(path):
	var dir = DirAccess.open(path)
	var frames = FileAccess.open(path + "/frames.json", FileAccess.READ)
	frames = frames.get_as_text()
	frames = JSON.parse_string(frames)
	
	var widths = FileAccess.open(path + "/widths.json", FileAccess.READ)
	widths = widths.get_as_text()
	widths = JSON.parse_string(widths)
	
	var heights = FileAccess.open(path + "/heights.json", FileAccess.READ)
	heights = heights.get_as_text()
	heights = JSON.parse_string(heights)
	
	if dir:
		for filename in dir.get_files():
			if filename.ends_with(".png"):
				var image = Image.load_from_file(path + "/" + filename)
				var tex = ImageTexture.create_from_image(image)
				var w = widths[filename.trim_suffix(".png")]
				var h = heights[filename.trim_suffix(".png")]
				var s = SpriteFrames.new()
				s.add_animation("default")
				s.set_animation_loop("default", true)
				s.set_animation_speed("default", 15.0)
				var num_frames = frames[filename.trim_suffix(".png")]
				var x = 0
				var y = 0
				label.text = filename
				for frame in range(num_frames):
					label.text += "."
					var atx = AtlasTexture.new()
					atx.atlas = tex
					atx.region = Rect2(x*w,y*h,w,h)
					s.add_frame("default", atx)
					x += 1
					if x == 10:
						x = 0
						y += 1
				var res = ResourceSaver.save(s, path + "/" + filename.trim_suffix(".png") + ".res")
				assert(res == OK)


func _on_button_4_pressed():
	var path = "res://Pokemon"
	var dir = DirAccess.open(path)
	
	if dir:
		for filename in dir.get_files():
			var p: Pokemon = ResourceLoader.load(path + "/" + filename, "Pokemon")
			for entry in p.sprites:
				p.sprites[entry] = p.sprites[entry].replace("res://sprites/pokemon/versions/generation-v/black-white/animated/", "res://sprites/pokemon/animated/")
				p.sprites[entry] = p.sprites[entry].replace(".gif", ".png")
			var res = ResourceSaver.save(p, path + "/" + filename)
			assert(res == OK)
	label.text = "done!"
	


func _on_button_5_pressed():
	var path = "res://Pokemon"
	var dir = DirAccess.open(path)
	
	if dir:
		for filename in dir.get_files():
			var p: Pokemon = ResourceLoader.load(path + "/" + filename, "Pokemon")
			for entry in p.sprites:
				if p.sprites[entry].contains("animated"):
					p.sprites[entry] = p.sprites[entry].replace(".png", ".res")
			var res = ResourceSaver.save(p, path + "/" + filename)
			assert(res == OK)
	label.text = "done!"
