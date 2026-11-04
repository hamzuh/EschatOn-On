extends Minigame

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("x") and not succeed:
		succeed = true
		end()
