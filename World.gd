extends Node


var is_settings_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	if error:
		print(error)
	
	$Settings.hide()


func _player_disconnected(id):
	print("Disconnecting player")
	$Players.remove_child($Players.get_node(str(id)))


func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_ESCAPE) and just_pressed and not is_settings_open:
		$Settings.show()
		is_settings_open = true
	elif Input.is_key_pressed(KEY_ESCAPE) and just_pressed and is_settings_open:
		$Settings.hide()
		is_settings_open = false
