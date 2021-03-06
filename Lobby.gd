extends Control


func _ready():
	# Called every time the node is added to the scene.
	var connection_failed_error = gamestate.connect("connection_failed", self, "_on_connection_failed")
	if connection_failed_error:
		print(connection_failed_error)
	
	var connection_succeeded_error = gamestate.connect("connection_succeeded", self, "_on_connection_success")
	if connection_succeeded_error:
		print(connection_succeeded_error)
	
	var player_list_changed_error = gamestate.connect("player_list_changed", self, "refresh_lobby")
	if player_list_changed_error:
		print(player_list_changed_error)
	
	var game_ended_error = gamestate.connect("game_ended", self, "_on_game_ended")
	if game_ended_error:
		print(game_ended_error)
	
	var game_error_error = gamestate.connect("game_error", self, "_on_game_error")
	if game_error_error:
		print(game_error_error)


func _on_Host_pressed():
	if $Connect/Name.get_selected_name() == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	$Connect.hide()
	$Players.show()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/Name.get_selected_name()
	gamestate.host_game(player_name)
	refresh_lobby()


func _on_Join_pressed():
	if $Connect/Name.get_selected_name() == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	var ip = $Connect/IPAddress.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IP address!"
		return

	$Connect/ErrorLabel.text = ""
	$Connect/Host.disabled = true
	$Connect/Join.disabled = true

	var player_name = $Connect/Name.get_selected_name()
	gamestate.join_game(ip, player_name)


func _on_connection_success():
	$Connect.hide()
	$Players.show()


func _on_connection_failed():
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")


func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func _on_game_error(errtxt):
	$ErrorDialog.dialog_text = errtxt
	$ErrorDialog.popup_centered_minsize()
	$Connect/Host.disabled = false
	$Connect/Join.disabled = false


func refresh_lobby():
	var players = gamestate.get_player_list()
	players.sort()
	$Players/List.clear()
	$Players/List.add_item(gamestate.get_player_name() + " (You)")
	for p in players:
		$Players/List.add_item(p)

	$Players/Start.disabled = not get_tree().is_network_server()


func _on_Start_pressed():
	gamestate.begin_game()
