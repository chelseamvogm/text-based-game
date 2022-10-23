extends Control

var _p_name = Player._p_name
var _p_hp = Player._p_hp
var _p_attack = Player._p_attack
var _p_defense = Player._p_defense
var _p_kane = Player._p_kane
var _p_hu_love = Player._p_hu_love
var _p_mo_love = Player._p_mo_love
var _p_dati = Player._p_dati
var _p_kill = Player._p_kill
var _playerdata = Player._playerdata

var g = preload("res://scene/sougen/goblin.tscn")
var sougen = [g]

var _savefile = "user://kimi.save"


func _save_datadayo():
	_playerdata = {
		"p_name" : _p_name,
		"p_hp" : _p_hp,
		"p_attack" : _p_attack,
		"p_defense" : _p_defense,
		"p_kane" : _p_kane,
		"p_hu_love" : _p_hu_love,
		"p_mo_love" : _p_mo_love,
		"p_dati" : _p_dati,
		"p_kill" : _p_kill
	}
	return _playerdata


func _ready():
	randomize()
	mon_kankei()
	hu_kankei()
	p_kinryoku()
	p_taisei()
	p_tairyoku()
	Player._load_suruyo()
	$ColorRect/pnamae.text = _p_name


func mon_kankei():
	if _p_mo_love >= 350:
		$ColorRect/mon_zyoutai2.text = "イイ感じ"
	elif _p_mo_love <= 349 and _p_mo_love >= 100:
		$ColorRect/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/mon_zyoutai2.text = "ヤバい感じ"


func hu_kankei():
	if _p_hu_love >= 350:
		$ColorRect/hu_zyoutai2.text  = "イイ感じ"
	elif _p_hu_love <= 349 and _p_hu_love >= 100:
		$ColorRect/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/hu_zyoutai2.text = "ヤバい感じ"


func p_kinryoku():
	if _p_attack >= 500:
		$ColorRect/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif _p_attack <= 499 and _p_attack >= 200:
		$ColorRect/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect/kinryoku_suuzi.text = "普通"


func p_taisei():
	if _p_defense >= 500:
		$ColorRect/taisei_suuzi.text  = "金属"
	elif _p_defense <= 499 and _p_defense >= 200:
		$ColorRect/taisei_suuzi.text = "布"
	else:
		$ColorRect/taisei_suuzi.text = "紙"


func p_tairyoku():
	if _p_hp >= 5000:
		$ColorRect/tairyoku_suuzi.text  = "超人"
	elif _p_hp <= 4999 and _p_hp >= 2000:
		$ColorRect/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect/tairyoku_suuzi.text = "常人"


func _on_sakihesusumu_pressed():
	var ran = sougen[randi() % sougen.size()]
	var random = randf()
	if random < 0.8:
		return get_tree().change_scene_to(ran)
	else:
		_p_hp = (_p_hp + 10)
		$Panel/message.text = "- ここには何もないようだ -\n- 引き続き調査しよう -"


func _on_home_pressed():
	$"home/modoru?".show()
	$"home/modoru?/Label".show()
	$"home/modoru?/hai".show()
	$"home/modoru?/iie".show()


func _on_iie_pressed():
	$"home/modoru?".hide()
	$"home/modoru?/Label".hide()
	$"home/modoru?/hai".hide()
	$"home/modoru?/iie".hide()


func _on_hai_pressed():
	return get_tree().change_scene("res://scene/kyotenti.tscn")


func _on_kakunin_pressed():
	pass

func _on_kakunin_toggled(_on_kakunin_pressed):
	if(_on_kakunin_pressed):
		$kakunin/kakunin_kontena.show()
		$kakunin/kakunin_sita.show()
	else:
		$kakunin/kakunin_kontena.hide()
		$kakunin/kakunin_sita.hide()


func _on_sonota_pressed():
	pass

func _on_sonota_toggled(_on_sonota_pressed):
	if(_on_sonota_pressed):
		$sonota/onota_kontena.show()
		$sonota/sonota_sita.show()
	else:
		$sonota/onota_kontena.hide()
		$sonota/sonota_sita.hide()


func _on_kiroku_pressed():
	$sonota/onota_kontena/kiroku/savesuru.show()

func _on_savesuru_pressed():
	Player._save_suruyo()
	$Panel/message.text = "今までの思い出を\n保存しときました。"
	$sonota/onota_kontena.hide()
	$sonota/sonota_sita.hide()

