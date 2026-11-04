extends Minigame

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("y") and not succeed:
		end()
		succeed = true
