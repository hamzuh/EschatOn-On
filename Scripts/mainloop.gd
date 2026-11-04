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
var goLeft: bool = true

func _ready() -> void:
	loadMinigame()
	
func loadMinigame():
	currentGame = minigames[minigameNum].instantiate()
	currentGame.connect("result", minigameEnd)
	viewport.add_child(currentGame)
	if not animations.is_playing() and not on:
		if tween:
			tween.kill()
		tween = create_tween()
		window.position = positions[pos]
		tween.tween_property(window, "position", Vector2(0, 0), 0.6)
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
		tween.set_ease(Tween.EASE_IN)
		if goLeft:
			tween.tween_property(window, "position", Vector2(-320, 0), 0.6).set_trans(Tween.TRANS_QUART)
		else:
			tween.tween_property(window, "position", Vector2(320, 0), 0.6).set_trans(Tween.TRANS_QUART)
		goLeft = !goLeft
		#tween.tween_property(window, "position", positions[pos], 0.6)
		#animations.play_backwards("spinin")
		on = !on
		currentGame.end()
		
		minigameNum += 1
		if minigameNum >= minigames.size():
			minigameNum = 0
			
		pos += 1
		if pos >= positions.size():
			pos = 0
		
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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spinin":
		currentGame.gameStart()
