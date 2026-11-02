extends Node

@onready var animations = $AnimationPlayer
@onready var window = $window
@onready var positions = $Board.posArray
@onready var viewport = $SubViewport
var pos = 0

var minigames: Array[PackedScene] = [load("res://Scenes/Minigames/xgame.tscn"), load("res://Scenes/Minigames/ygame.tscn")]
var minigameNum = 0
var currentGame: Node
var on: bool = false
var tween

func _ready() -> void:
	loadMinigame()
	
func loadMinigame():
	currentGame = minigames[minigameNum].instantiate()
	currentGame.connect("result", minigameEnd)
	viewport.add_child(currentGame)
	if not animations.is_playing():
		if not on:
			if tween:
				tween.kill()
			tween = create_tween()
			window.position = positions[pos]
			tween.tween_property(window, "position", Vector2(0, 0), 0.75)
			animations.play("spinin")
			on = !on
	
func minigameEnd(success):
	if on and not animations.is_playing():
		#if success:
			#add_child()
			## success sprite or toggle existing sprite
		#else:
			## fail sprite
		if tween:
			tween.kill()
		tween = create_tween()
		window.position = Vector2(0, 0)
		tween.tween_property(window, "position", positions[pos], 0.75)
		animations.play_backwards("spinin")
		on = !on
		pos += 1
		currentGame.end()
		minigameNum += 1
		if minigameNum >= minigames.size():
			minigameNum = 0
		await get_tree().create_timer(1.0).timeout
		loadMinigame()

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("prang") and not animations.is_playing():
		#var tween
		#if not on:
			#if tween:
				#tween.kill()
			#tween = create_tween()
			#window.position = positions[pos]
			#tween.tween_property(window, "position", Vector2(0, 0), 0.75)
			#animations.play("spinin")
			#on = !on
		#else:
			#if tween:
				#tween.kill()
			#tween = create_tween()
			#window.position = Vector2(0, 0)
			#tween.tween_property(window, "position", positions[pos], 0.75)
			#animations.play_backwards("spinin")
			#on = !on
			#pos += 1
			#currentGame.end()
			
func _input(event: InputEvent) -> void:
	if on:
		viewport.push_input(event)
