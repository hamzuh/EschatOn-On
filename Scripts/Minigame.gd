class_name Minigame extends Node2D

@onready var succeed: bool = false

signal result(resultBool)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func gameStart():
	process_mode = Node.PROCESS_MODE_INHERIT
	
func end():
	process_mode = Node.PROCESS_MODE_DISABLED
	result.emit(succeed)
