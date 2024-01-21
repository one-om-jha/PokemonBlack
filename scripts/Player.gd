extends CharacterBody3D

enum PlayerState {
	idle,
	walk,
	run
}

var state: PlayerState = PlayerState.idle

var last_direction: Vector2i

var gravity = 5

@onready var sprite = $PlayerSprite

func move_player(direction, run):
	# change states
	if run:
		state = PlayerState.run
	else:
		state = PlayerState.walk
	if direction.length() == 0:
		state = PlayerState.idle
	else:
		last_direction = direction

	velocity = Vector3(direction.x, 0, direction.y).normalized()
	
	if state == PlayerState.run:
		velocity *= 2
		
	if !is_on_floor():
		velocity += Vector3(0, -gravity, 0)
	
	move_and_slide()
	update_anim()

func update_anim():
	var dir = get_cardinal_direction()
	match state:
		PlayerState.idle:
			sprite.play_idle(dir)
		PlayerState.walk:
			sprite.play_walk(dir)
		PlayerState.run:
			sprite.play_run(dir)

func get_cardinal_direction() -> Vector2i:
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			return Vector2i.RIGHT
		else:
			return Vector2i.LEFT
	else:
		if last_direction.y < 0:
			return Vector2i.UP
		else:
			return Vector2i.DOWN
