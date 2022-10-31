extends Control

var sonota_count : bool = false
var kakunin_count : bool = false


func _mon_kankei():
	if Player._p_mo_love >= 350:
		$ColorRect/mon_zyoutai/mon_zyoutai2.text = "イイ感じ"
	elif Player._p_mo_love <= 349 and Player._p_mo_love >= 100:
		$ColorRect/mon_zyoutai/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/mon_zyoutai/mon_zyoutai2.text = "ヤバい感じ"


func _hu_kankei():
	if Player._p_hu_love >= 350:
		$ColorRect/hu_zyoutai/hu_zyoutai2.text  = "イイ感じ"
	elif Player._p_hu_love <= 349 and Player._p_hu_love >= 100:
		$ColorRect/hu_zyoutai/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/hu_zyoutai/hu_zyoutai2.text = "ヤバい感じ"


func _p_kinryoku():
	if Player._p_attack >= 500:
		$ColorRect/kinryoku/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif Player._p_attack <= 499 and Player._p_attack >= 200:
		$ColorRect/kinryoku/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect/kinryoku/kinryoku_suuzi.text = "普通"


func _p_taisei():
	if Player._p_defense >= 500:
		$ColorRect/taisei/taisei_suuzi.text  = "金属"
	elif Player._p_defense <= 499 and Player._p_defense >= 200:
		$ColorRect/taisei/taisei_suuzi.text = "布"
	else:
		$ColorRect/taisei/taisei_suuzi.text = "紙"


func _p_tairyoku():
	if Player._p_hp >= 5000:
		$ColorRect/tairyoku/tairyoku_suuzi.text  = "超人"
	elif Player._p_hp <= 4999 and Player._p_hp >= 2000:
		$ColorRect/tairyoku/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect/tairyoku/tairyoku_suuzi.text = "常人"


func _ready():
	randomize()
	_mon_kankei()
	_hu_kankei()
	_p_kinryoku()
	_p_taisei()
	_p_tairyoku()
	Player._load_suruyo()
	$ColorRect/areanamae.text = Player._p_name + "の思い出"
	$ColorRect/syozikin/syozikin_suuzi.text = str(Player._p_kane)
	$ColorRect/dati_mon/dati_mon2.text = str(Player._p_mon_dati_count)
	$ColorRect/dati_hu/dati_hu2.text = str(Player._p_hu_dati_count)
	$ColorRect/katemon/katemon2.text = str(Player._p_mon_kill_count)
	$ColorRect/katehu/katehu2.text = str(Player._p_hu_kill_count)


func _on_sonota_pressed():
	if sonota_count == false:
		sonota_count = true
		$sonota/onota_kontena.show()
		$sonota/sonota_sita.show()
	else:
		sonota_count = false
		$sonota/onota_kontena.hide()
		$sonota/sonota_sita.hide()


func _on_kiroku_pressed():
	$sonota/onota_kontena/kiroku/savesuru.show()


func _on_savesuru_pressed():
	Player._save_suruyo()
	$Panel/message.text = "今までの思い出を\n保存しときました。"
	$sonota/onota_kontena.hide()
	$sonota/sonota_sita.hide()


func _on_savesinai_pressed():
	$sonota/sonota_sita.hide()
	$sonota/onota_kontena.hide()


func _on_modoru_pressed():
	return get_tree().current_scene.filename
