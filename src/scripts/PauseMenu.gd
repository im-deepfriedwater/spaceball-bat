extends Control

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_pause"):
		var isPaused = get_tree().paused
		get_tree().paused = !isPaused
		visible = !isPaused


