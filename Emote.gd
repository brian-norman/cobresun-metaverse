extends AnimatedSprite

var emotion = "smile"


func _ready():
	play(emotion)


func _on_Timer_timeout():
	queue_free()
