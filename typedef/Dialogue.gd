class_name Dialogue extends Resource

enum DialogueType {
	BOX,
	BOTTOM,
	FLOATING
}

@export var speaker: String
@export var text: String
@export var type: DialogueType
@export var pos: Vector2
