extends Node2D

@onready var spaces: int = 11
@onready var currentPos: int = 0

@onready var posArray: PackedVector2Array = [Vector2(-100, -60), Vector2(-20, -60), Vector2(60, -60), Vector2(-60, -20), Vector2(20, -20), Vector2(100, -20), Vector2(-100, 20), Vector2(-20, 20), Vector2(60, 20), Vector2(-60, 60), Vector2(20, 60), Vector2(100, 60)]
