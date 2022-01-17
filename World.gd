extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_disconnected", self,"_player_disconnected")


func _player_disconnected(id):
	print("Disconnecting player")
	$Players.remove_child($Players.get_node(str(id)))
