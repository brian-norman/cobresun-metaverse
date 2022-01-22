extends ItemList


var PlayerListContent = ["brian","cole","wesley","sunny"]


# Called when the node enters the scene tree for the first time.
func _ready():
	for ItemID in range(4):
		add_item(PlayerListContent[ItemID], null, true)
	
	select(0, true)


func get_selected_name():
	var selected_index = get_selected_items()[0]
	return get_item_text(selected_index)
