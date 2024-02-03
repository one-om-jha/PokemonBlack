extends State

@onready var player = $Player
@onready var camera = $Player/Camera3D

func enter_state():
	player.sprite.load_sprite()
	camera.current = true
	player.global_position = pd.data.map_pos + Vector3(0,1,0)

func update(delta):
	var vert = Input.get_axis("up", "down")
	var hori = Input.get_axis("left", "right")
	var direction = Vector2i(hori, vert)
	var running: bool = Input.is_action_pressed("run")
	player.move_player(direction, running)
	pd.data.map = "overworld"
	pd.data.map_pos = player.global_position
	
	if Input.is_action_just_pressed("menu"):
		get_parent().push_state(get_parent().menu_state)


func _on_trigger_battle(battle):
	get_parent().init_battle(battle)
