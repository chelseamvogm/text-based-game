extends Control

func _mon_kankei():
	if Player._p_mo_love >= 350:
		$ColorRect/mon_zyoutai2.text = "イイ感じ"
	elif Player._p_mo_love <= 349 and Player._p_mo_love >= 100:
		$ColorRect/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/mon_zyoutai2.text = "ヤバい感じ"


func _hu_kankei():
	if Player._p_hu_love >= 350:
		$ColorRect/hu_zyoutai2.text  = "イイ感じ"
	elif Player._p_hu_love <= 349 and Player._p_hu_love >= 100:
		$ColorRect/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/hu_zyoutai2.text = "ヤバい感じ"


func _p_kinryoku():
	if Player._p_attack >= 500:
		$ColorRect/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif Player._p_attack <= 499 and Player._p_attack >= 200:
		$ColorRect/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect/kinryoku_suuzi.text = "普通"


func _p_taisei():
	if Player._p_defense >= 500:
		$ColorRect/taisei_suuzi.text  = "金属"
	elif Player._p_defense <= 499 and Player._p_defense >= 200:
		$ColorRect/taisei_suuzi.text = "布"
	else:
		$ColorRect/taisei_suuzi.text = "紙"


func _p_tairyoku():
	if Player._p_hp >= 5000:
		$ColorRect/tairyoku_suuzi.text  = "超人"
	elif Player._p_hp <= 4999 and Player._p_hp >= 2000:
		$ColorRect/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect/tairyoku_suuzi.text = "常人"


func _ready():
	Player._load_suruyo()
	_mon_kankei()
	_hu_kankei()
	_p_kinryoku()
	_p_taisei()
	_p_tairyoku()
	$ColorRect/pnamae.text = Player._p_name


func _on_tyousani_iku_pressed():
	return get_tree().change_scene("res://scene/kyotenti.tscn")


func _on_kakunin_pressed():
	$Popup.popup()


func _on_dougu_pressed():
	$Popup.hide()
	$item.popup()


func _on_item_modoru_pressed():
	$item.hide()


func _on_status_pressed():
	$Popup.hide()
	$status.popup()


func _on_status_modoru_pressed():
	$status.hide()


func _on_tyousasyo_pressed():
	$Popup.hide()
	$tyousasyo.popup()


func _on_tyousasyo_modoru_pressed():
	$tyousasyo.hide()


func _on_sonota_pressed():
	$settei.popup()


func _on_kiroku_pressed():
	$settei.hide()
	$savesuru.popup()


func _on_savesuru_pressed():
	Player._save_suruyo()
	$Panel/message.text = "今までの思い出を\n保存しときました。"
	$settei.hide()
	$savesuru.hide()


func _on_savesinai_pressed():
	$savesuru.hide()


func _on_sougen_pressed():
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")
