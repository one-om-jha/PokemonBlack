extends Area3D

@export var music: AudioStream
@onready var player = $"../../AudioStreamPlayer"

func _on_body_entered(body):
	if body.name == "Player":
		if player.stream != music:
			player.stream = music
			player.play()
