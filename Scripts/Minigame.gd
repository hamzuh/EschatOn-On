class_name Minigame extends Node2D

@onready var succeed: bool = false

signal result(resultBool)

func _ready() -> void:
	pass

func spawn():
	pass
	
func end():
	result.emit(succeed)
