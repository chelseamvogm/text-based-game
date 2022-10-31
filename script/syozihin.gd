extends Control


func _ready():
	Player._load_suruyo()
	for x in Player._p_item:
		var button = $ColorRect/ScrollContainer/VBoxContainer/Button.duplicate(8)
		button.add_to_group("item_button")
		button.text = Itemdatabase._item_zyouhou(x)._namae
		button.icon = Itemdatabase._item_zyouhou(x).texture
		$ColorRect/ScrollContainer/VBoxContainer.add_child(button)
	for button in get_tree().get_nodes_in_group("item_button"):
		button.connect("pressed", self, "_some_button_pressed", [button])
	$ColorRect/ScrollContainer/VBoxContainer/Button.hide()


func _some_button_pressed(button):
	var _x = button.get_text()
	$Panel/namae.text = Itemdatabase._item_zyouhou(_x)._namae
	$Panel/setumei.text = Itemdatabase._item_zyouhou(_x)._setumei
	$Panel/TextureRect.texture = Itemdatabase._item_zyouhou(_x).texture
