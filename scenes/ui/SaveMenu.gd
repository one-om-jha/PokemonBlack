extends State

@onready var Save1 = $SaveButtons/Save1
@onready var Save2 = $SaveButtons/Save2
@onready var Save3 = $SaveButtons/Save3
@onready var anim = $AnimationPlayer

func enter_state():
	anim.play("open")
	Save1.grab_focus()
	for child in $SaveButtons.get_children():
		child.disabled = false
	load_saves()
		
func exit_state():
	anim.play("close")
	for child in $SaveButtons.get_children():
		child.disabled = true

func update(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().pop_state()

func _on_save_1_pressed():
	pd.save(1)
	load_saves()

func _on_save_2_pressed():
	pd.save(2)
	load_saves()

func _on_save_3_pressed():
	pd.save(3)
	load_saves()

func load_saves():
	var save_1 = ResourceLoader.load("user://save1.tres", "PlayerData")
	if save_1 != null:
		Save1.load_save(save_1)
	var save_2 = ResourceLoader.load("user://save2.tres", "PlayerData")
	if save_2 != null:
		Save2.load_save(save_2)
	var save_3 = ResourceLoader.load("user://save3.tres", "PlayerData")
	if save_3 != null:
		Save3.load_save(save_3)
