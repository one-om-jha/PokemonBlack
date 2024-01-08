extends State

@onready var question_label = $Label
@onready var textedit = $TextEdit
@onready var anim = $AnimationPlayer

@export var question: String
@export var sprite: String
@export var char_limit: int

signal submitted(text)

func enter_state():
	textedit.editable = true
	textedit.grab_focus()
	anim.play("start")
	
func exit_state():
	textedit.editable = false
	anim.play("close")
	submitted.emit(textedit.text)

func _on_text_edit_text_submitted(new_text):
	exit_state()
