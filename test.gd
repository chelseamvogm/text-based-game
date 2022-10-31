extends Control


func _ready():
	Player._load_suruyo()
	for x in Player._p_item:
		var button = $Button2/PopupMenu/ScrollContainer/VBoxContainer/Button.duplicate(8)
		button.add_to_group("item_button")
		button.text = Itemdatabase._item_zyouhou(x)._namae
		button.icon = Itemdatabase._item_zyouhou(x).texture
		$Button2/PopupMenu/ScrollContainer/VBoxContainer.add_child(button)
	for button in get_tree().get_nodes_in_group("item_button"):
		button.connect("pressed", self, "_some_button_pressed", [button])
	$Button2/PopupMenu/ScrollContainer/VBoxContainer/Button.hide()




func _on_ageru_pressed():
	Player._save_suruyo()
	pass


func _on_tukau_pressed():
	Itemdatabase._item_tukau("ゴブリンのグルグルパン")
	print(Player._p_item)


func _on_morau_pressed():
	Itemdatabase._item_morau("ゴブリンのふかふかパン")
	Itemdatabase._item_morau("ゴブリンのぬいぐるみ")
	Itemdatabase._item_morau("ゴブリンのカチカチパン")
	Itemdatabase._item_morau("ゴブリンのグルグルパン")



func _on_Button_pressed():
	return get_tree().change_scene("res://scene/syozihin.tscn")



func _on_Button2_pressed():
	$Button2/PopupMenu.popup()
	pass
