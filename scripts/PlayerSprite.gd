extends AnimatedSprite3D

@onready var bob = $SpriteBobPlayer

var male_sprite = preload("res://textures/player/player_male.tres")
var female_sprite = preload("res://textures/player/player_female.tres")

func load_sprite():
	match pd.data.gender:
		0:
			# boy
			set_sprite_frames(male_sprite)
			pass
		1:
			# girl
			set_sprite_frames(female_sprite)
			pass

func play_idle(dir):
	bob.play("idle")
	match dir:
		Vector2i.DOWN:
			play("idle_down")
		Vector2i.LEFT:
			play("idle_left")
		Vector2i.RIGHT:
			play("idle_right")
		Vector2i.UP:
			play("idle_up")

func play_walk(dir):
	bob.play("move")
	match dir:
		Vector2i.DOWN:
			play("walk_down")
		Vector2i.LEFT:
			play("walk_left")
		Vector2i.RIGHT:
			play("walk_right")
		Vector2i.UP:
			play("walk_up")
			
func play_run(dir):
	bob.play("move")
	match dir:
		Vector2i.DOWN:
			play("run_down")
		Vector2i.LEFT:
			play("run_left")
		Vector2i.RIGHT:
			play("run_right")
		Vector2i.UP:
			play("run_up")
