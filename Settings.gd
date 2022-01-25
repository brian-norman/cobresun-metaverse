extends Node2D

signal volume_changed(value)

func _on_Volume_value_changed(value):
	emit_signal("volume_changed", value)
