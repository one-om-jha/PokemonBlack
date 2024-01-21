extends State

@onready var floating = $Floating
@onready var floating_text = $Floating/Text
@onready var timer = $Timer

var vis_char = 0
var frames = 1
var curr_frames = 0
var displaying = false

signal finished_dialogue

func _ready():
	floating.visible = false

func _process(delta):
	if displaying:
		curr_frames += 1
		if curr_frames == frames:
			curr_frames = 0
			vis_char += 1
			floating_text.visible_characters = vis_char
		if floating_text.visible_ratio > 1.0:
			displaying = false
			vis_char = 0
			curr_frames = 0
			#finished_dialogue.emit()

func display(dialogue: String):
	floating.visible = true
	floating_text.text = dialogue.replace("\\n", "\n")
	floating_text.visible_characters = 0
	displaying = true
	timer.start()

func hide_text():
	floating.visible = false

func _on_timer_timeout():
	hide_text()
	finished_dialogue.emit()
