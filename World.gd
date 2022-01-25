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


func _on_Settings_volume_changed(value):
	var volume = 0
	if value == 0:
		volume = -51
	elif value == 10:
		volume = -30.8
	elif value == 20:
		volume = -22.4
	elif value == 30:
		volume = -17.1
	elif value == 40:
		volume= -13.1
	elif value == 50:
		volume = -10.0
	elif value == 60:
		volume = -7.4
	elif value == 70:
		volume =  -4.9
	elif value == 80:
		volume =  -3.2
	elif value == 90:
		volume = -1.3
	else:
		volume = 0
	
	$Music.volume_db = volume
