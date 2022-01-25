extends AnimatedSprite

export (String) var emotion = "smile"

# If set to true, the timer timeout won't be respected... aka this emoticon doesn't go away
export (bool) var infinite = false


func _ready():
	play(emotion)


func _on_Timer_timeout():
	if not infinite:
		queue_free()


func _on_Volume_value_changed(value):
	pass # Replace with function body.
