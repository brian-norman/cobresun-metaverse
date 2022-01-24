extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var error = get_tree().connect("network_peer_disconnected", self,"_player_disconnected")
	if error:
		print(error)


func _player_disconnected(id):
	print("Disconnecting player")
	$Players.remove_child($Players.get_node(str(id)))
