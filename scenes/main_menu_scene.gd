extends Node3D

var world_scene = preload("res://scenes/world.tscn")
var save_scene = preload("res://scenes/save_scene.tscn")
@onready var anim_player = $AnimationPlayer
@onready var audio = $AudioStreamPlayer

func _input(event):
	if event.is_pressed():
		anim_player.play("start")

func change_scene():
	get_tree().change_scene_to_packed(save_scene)


func _on_audio_stream_player_finished():
	audio.play()
