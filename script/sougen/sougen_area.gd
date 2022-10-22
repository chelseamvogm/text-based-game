extends Control

var p_name = Player.p_name
var p_hu_love = Player.p_hu_love
var p_mo_love = Player.p_mo_love
var p_hp = Player.p_hp
var p_attack = Player.p_attack
var p_defense = Player.p_defense
var p_dati = Player.p_dati

var g = preload("res://scene/sougen/goblin.tscn")
var k = preload("res://scene/sougen/koumori.tscn")
var sougen = [g, k]
var p

func _ready():
	randomize()
	mon_kankei()
	hu_kankei()
	p_kinryoku()
	p_taisei()
	p_tairyoku()
	$ColorRect/pnamae.text = p_name


func mon_kankei():
	if p_mo_love >= 350:
		$ColorRect/mon_zyoutai2.text = "イイ感じ"
	elif p_mo_love <= 349 and p_mo_love >= 100:
		$ColorRect/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/mon_zyoutai2.text = "ヤバい感じ"

func hu_kankei():
	if p_hu_love >= 350:
		$ColorRect/hu_zyoutai2.text  = "イイ感じ"
	elif p_hu_love <= 349 and p_hu_love >= 100:
		$ColorRect/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect/hu_zyoutai2.text = "ヤバい感じ"

func p_kinryoku():
	if p_attack >= 500:
		$ColorRect/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif p_attack <= 499 and p_attack >= 200:
		$ColorRect/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect/kinryoku_suuzi.text = "普通"

func p_taisei():
	if p_defense >= 500:
		$ColorRect/taisei_suuzi.text  = "金属"
	elif p_defense <= 499 and p_defense >= 200:
		$ColorRect/taisei_suuzi.text = "布"
	else:
		$ColorRect/taisei_suuzi.text = "紙"

func p_tairyoku():
	if p_hp >= 5000:
		$ColorRect/tairyoku_suuzi.text  = "超人"
	elif p_hp <= 4999 and p_hp >= 2000:
		$ColorRect/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect/tairyoku_suuzi.text = "常人"

func _on_sakihesusumu_pressed():
	var ran = sougen[randi() % sougen.size()]
	var random = randf()
	if random < 0.1:
		p_hp = (p_hp + 10)
		$Panel/message.text = "- ここには何もないようだ -\n- 引き続き調査しよう -"
		print(p_hp)
	elif random < 0.8:
		return get_tree().change_scene_to(ran)
	else:
		p_hp = (p_hp + 10)
		$Panel/message.text = "- ここには何もないようだ -\n- 引き続き調査しよう -"
