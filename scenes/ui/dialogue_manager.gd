extends State

@onready var floating = $Floating
@onready var floating_text = $Floating/Text
@onready var floating_speaker = $Floating/Speaker

@onready var bottom = $Bottom
@onready var bottom_text = $Bottom/Text
@onready var bottom_speaker = $Bottom/Speaker

@onready var box = $Box
@onready var box_text = $Box/Text
@onready var box_speaker = $Box/Speaker

@onready var choice = $Choice
@onready var choice_one = $"Choice/Choice One"
@onready var choice_two = $"Choice/Choice Two"

@export var dialogue_list: Array[Dialogue]
@export var current_dialogue = 0

var vis_char = 0
var frames = 1
var curr_frames = 0
var displaying = false

@onready var curr_speaker = $Floating/Speaker
@onready var curr_text = $Floating/Text

signal finished_dialogue
signal displayed(index)
signal choice_selected(choice)

func _ready():
	floating.visible = false
	bottom.visible = false
	box.visible = false
	choice.visible = false

func _process(delta):
	if displaying:
		curr_frames += 1
		if curr_frames == frames:
			curr_frames = 0
			vis_char += 1
			curr_text.visible_characters = vis_char
		if curr_text.visible_ratio > 1.0:
			displaying = false
			vis_char = 0
			curr_frames = 0
			displayed.emit(current_dialogue)

func display_next():
	if displaying:
		return
	
	if current_dialogue < dialogue_list.size():
		hide_text()
		var curr: Dialogue = dialogue_list[current_dialogue]
		match curr.type:
			Dialogue.DialogueType.BOX:
				box.visible = true
				curr_speaker = box_speaker
				curr_text = box_text
			Dialogue.DialogueType.BOTTOM:
				bottom.visible = true
				curr_speaker = bottom_speaker
				curr_text = bottom_text
			Dialogue.DialogueType.FLOATING:
				floating.visible = true
				curr_speaker = floating_speaker
				curr_text = floating_text
			_:
				pass
		curr_speaker.text = curr.speaker
		curr_text.text = curr.text.replace("\\n", "\n")
		curr_text.visible_characters = 0
		displaying = true
		current_dialogue += 1
	else:
		pass

func hide_text():
	floating.visible = false
	bottom.visible = false
	box.visible = false
	choice.visible = false

func display_choice(choice1, choice2):
	choice.visible = true
	choice_one.text = choice1
	choice_two.text = choice2
	choice_one.grab_focus()

func hide_choice():
	choice.visible = false
	choice_one.disabled = true
	choice_two.disabled = true

func _on_choice_one_pressed():
	choice_selected.emit(1)
	hide_choice()

func _on_choice_two_pressed():
	choice_selected.emit(2)
	hide_choice()
