extends Control

const namae = "コウモリ"
const area = "sougen"
const hu_love := 8
const mo_love := 8
const attack := 2000
const defense := 2000
const love_pw := 75
const max_hp := 7500

onready var sentou = $sentou
onready var koudou = $koudou
onready var aisatu = $koudou/aisatu
onready var kaiwa = $koudou/kaiwa
onready var okurimono = $koudou/okurimono
onready var batou = $koudou/batou
onready var kakunin = $kakunin
onready var nigeru = $nigeru
onready var bunsyo = $Panel/message

onready var p_name = Player.p_name
onready var p_hu_love = Player.p_hu_love
onready var p_mo_love = Player.p_mo_love
onready var p_attack = Player.p_attack
onready var p_defense = Player.p_defense
onready var p_dati = Player.p_dati

var p_love : int
var hp := 7500
var count = 0
var damage_count = 0
var kill_count = 0

func _ready():
	randomize()
	mon_kankei()
	hu_kankei()
	Player.load_suruyo()
	bunsyo.text = namae + "と出会った。\nどうする？"
	$ColorRect/name.text = namae


func saisyonogamen():
	mon_kankei()
	hu_kankei()
	p_kankei()
	if count >= 3:
		Player.save_suruyo()
		sentou.hide()
		koudou.hide()
		kakunin.hide()
		nigeru.hide()
		aisatu.hide()
		kaiwa.hide()
		okurimono.hide()
		batou.hide()
		$sentou/kill.hide()
		$sentou/utinomesu.hide()
		$saikindo.hide()
		$tomodati.hide()
		$tugihe.show()
		$modoru.hide()
	else:
		sentou.show()
		koudou.show()
		kakunin.show()
		nigeru.show()
		aisatu.hide()
		kaiwa.hide()
		okurimono.hide()
		batou.hide()
		$sentou/kill.hide()
		$sentou/utinomesu.hide()
		$saikindo.hide()
		$tomodati.hide()
		$tugihe.hide()
		$modoru.hide()
	return

func p_kankei():
	if p_love >= love_pw:
		datigamen()
	elif p_love <= love_pw and p_love >= 35:
		$ColorRect/dou.text = "知り合い"
	else:
		$ColorRect/dou.text = "初対面"
	pass


func _on_koudou_pressed():
	aisatu.show()
	kaiwa.show()
	okurimono.show()
	batou.show()



func _on_aisatu_pressed():
	var _word = ["ワア、ニンゲンダ！", "ナンダオマエ", "ウルサイ！コッチクルナ！"]
	var _word2 = ["ナンダオマエカ。ゲンキカ？", p_name + "カ。ヘロー"]
	var _word3 = ["ウワッ、コッチクンジャネエ！", "オマエ…ナンノツモリダ…？", "オレサマニナンカヨウカヨ"]
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	var _random_word = _word[randi() % _word.size()]
	var _random_word2 = _word2[randi() % _word2.size()]
	var _random_word3 = _word3[randi() % _word3.size()]
	if p_love >= 50 and damage_count == 0 and kill_count == 0:
		bunsyo.text = _random_word2
		p_love = (p_love + 5)
		p_mo_love = (p_mo_love + mo_love)
		p_hu_love= (p_hu_love - hu_love)
		count += 1
	elif damage_count >= 1 or kill_count >= 1:
		bunsyo.text = _random_word3
		p_love = (p_love + 3)
		p_mo_love = (p_mo_love + mo_love)
		p_hu_love= (p_hu_love - hu_love)
		count += 1
	else:
		bunsyo.text = _random_word
		p_love = (p_love + 3)
		p_mo_love = (p_mo_love + mo_love)
		p_hu_love= (p_hu_love - hu_love)
		count += 1
	print(p_mo_love, p_love, count)
	return saisyonogamen()


func _on_kaiwa_pressed():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	$saikindo.show()


func _on_sentou_pressed():
	aisatu.hide()
	kaiwa.hide()
	okurimono.hide()
	batou.hide()
	$sentou/kill.show()
	$sentou/utinomesu.show()


func _on_kakunin_pressed():
	pass # Replace with function body.


func _on_saikindo_pressed():
	var _word = [p_name + "ハカワッタヤツダナ\nオレサマハジョウキゲンダ！", "キョウハイイヒダゾ！\nオマエニアエタカラナ！", p_name + "二アゲヨウトオモッテナ、\nコレ、ヨウイシタンダ"]
	var _word2 = ["…ナンノマネダ、オマエ", "オマエニハナスコトハ、ナンモネエヨ", "ウワッ！コッチクンジャネエ！"]
	var _word3 = ["ン？キョウカ？ベツニ？", "ドウッテ…\nイツモドーリ、オマエタチニンゲンカラ\nニゲテルダケダゼ", "チョウシカー…ビミョー"]
	var _ran_w = _word[randi() % _word.size()]
	var _ran_w2 = _word2[randi() % _word2.size()]
	var _ran_w3 = _word3[randi() % _word3.size()]
	if damage_count >= 1 or kill_count >= 1:
		bunsyo.text = _ran_w2
		p_love = (p_love + 2)
		p_mo_love = (p_mo_love + (mo_love - 7))
		p_hu_love = (p_hu_love - hu_love)
		count += 1
	elif p_love >= 50:
		bunsyo.text = _ran_w
		p_love = (p_love + 5)
		p_mo_love = (p_mo_love + (mo_love - 5))
		p_hu_love = (p_hu_love - hu_love)
		count += 1
	else:
		bunsyo.text = _ran_w3
		p_love = (p_love + 5)
		p_mo_love = (p_mo_love + (mo_love - 5))
		p_hu_love = (p_hu_love - hu_love)
		count += 1
	print(p_mo_love, p_love, count)
	return saisyonogamen()


func datigamen():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	aisatu.hide()
	kaiwa.hide()
	okurimono.hide()
	batou.hide()
	$sentou/kill.hide()
	$sentou/utinomesu.hide()
	$saikindo.hide()
	$tomodati.show()
	$tugihe.hide()
	$modoru.hide()
	$ColorRect/dou.text = "???"
	$Panel/message.text = "………"



func _on_tomodati_pressed():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	aisatu.hide()
	kaiwa.hide()
	okurimono.hide()
	batou.hide()
	$sentou/kill.hide()
	$sentou/utinomesu.hide()
	$saikindo.hide()
	$tomodati.hide()
	$modoru.show()
	$ColorRect/dou.text = "友達"
	p_dati.append_array(namae)
	if damage_count == 0:
		bunsyo.text = "ハハッ！\nヤッパリ" + p_name + "ハヘンナヤツダナ！\nイイゼ、キョウカラハ ダチコウ ナ！"
	else:
		bunsyo.text = "…オマエガドウシテモッテイウナラ…\nキョウリョクシテヤッテモイイガ…\n…ヨミチニキヲツケロヨ" 


func _on_kill_pressed():
	hp = hp - ((defense - p_attack) + p_love) * 100
	p_love = (p_love - 20)
	p_hu_love = (p_hu_love + hu_love)
	p_mo_love = (p_mo_love - mo_love)
	p_attack = (p_attack + randi() % 10)
	p_defense = (p_defense + randi() % 10)
	count += 1
	damage_count += 1
	var _word = ["グッ…！", "ガッ…！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		bunsyo.text = ran_word
		saisyonogamen()
	else:
		dead()
	print(p_attack,p_defense)

func dead():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	aisatu.hide()
	kaiwa.hide()
	okurimono.hide()
	batou.hide()
	$sentou/kill.hide()
	$sentou/utinomesu.hide()
	$saikindo.hide()
	$modoru.hide()
	$tomodati.hide()
	$tugihe.show()
	bunsyo.text = "…ニンゲン…オボエテロヨ…"
	p_love = 0
	p_hu_love = (p_hu_love - hu_love)
	p_mo_love = (p_mo_love - mo_love)
	damage_count += 1
	kill_count += 1


func _on_tugihe_pressed():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	aisatu.hide()
	kaiwa.hide()
	okurimono.hide()
	batou.hide()
	$sentou/kill.hide()
	$sentou/utinomesu.hide()
	$saikindo.hide()
	$tomodati.hide()
	$tugihe.hide()
	$modoru.show()
	$gazou.hide()
	if damage_count >= 1 and kill_count >= 1:
		bunsyo.text = "-おめでとう！あなたは戦闘に勝利しました！-\n-この調子で頑張りましょう！-"
	elif count ==3:
		bunsyo.text = "-" + namae + "は帰っていきました-\n-引き続き調査しましょう！-"


func mon_kankei():
	if p_mo_love >= 350:
		$ColorRect/mon_kankei2.text = "イイ感じ"
	elif p_mo_love <= 349 and p_mo_love >= 100:
		$ColorRect/mon_kankei2.text = "そこそこな感じ"
	else:
		$ColorRect/mon_kankei2.text = "ヤバい感じ"

func hu_kankei():
	if p_hu_love >= 350:
		$ColorRect/hu_kankei2.text  = "イイ感じ"
	elif p_hu_love <= 349 and p_hu_love >= 100:
		$ColorRect/hu_kankei2.text = "そこそこな感じ"
	else:
		$ColorRect/hu_kankei2.text = "ヤバい感じ"


func _on_utinomesu_pressed():
	hp = hp - ((defense - p_attack) + p_love)
	p_love = (p_love - 10)
	p_hu_love = (p_hu_love + hu_love)
	p_mo_love = (p_mo_love - mo_love)
	p_attack = (p_attack + randi() % 5)
	p_defense = (p_defense + randi() % 5)
	count += 1
	damage_count += 1
	var _word = ["イッテ！ナニスンダ！", "ヤッパリオマエモ…\nコノメダマガネライカ！", "ヤメロ！イテエジャネエカ！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		bunsyo.text = ran_word
		saisyonogamen()
	else:
		dead()
	print(p_attack,p_defense)


func _on_batou_pressed():
	var _word = ["………", "ケッ", "アーハイハイ、\nニンゲンサマガイチバンデスネー"]
	var _word2 = ["オイ…" + p_name + "…\nキュウニドウシタンダヨ？", "…オイオイ…ヒデエゼ…"]
	var _word3 = ["ナンダオマエ、\nオレサマトヤロウッテノカ？", "…ケッキョクオマエモカヨ…", "…クソガ…"]
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	var _random_word = _word[randi() % _word.size()]
	var _random_word2 = _word2[randi() % _word2.size()]
	var _random_word3 = _word3[randi() % _word3.size()]
	if p_love >= 50:
		bunsyo.text = _random_word2
		p_love = (p_love - 3)
		p_mo_love = (p_mo_love - 3)
		p_hu_love= (p_hu_love + hu_love)
		count += 1
		damage_count += 1
	elif p_love >= 10 and p_love <= 49:
		bunsyo.text = _random_word3
		p_love = (p_love - 3)
		p_mo_love = (p_mo_love - 3)
		p_hu_love= (p_hu_love + hu_love)
		count += 1
		damage_count += 1
	else:
		bunsyo.text = _random_word
		p_love = (p_love - 3)
		p_mo_love = (p_mo_love - 3)
		p_hu_love= (p_hu_love + hu_love)
		count += 1
		damage_count += 1
	print(p_mo_love, p_love, count)
	return saisyonogamen()




func _on_modoru_pressed():
	Player.save_suruyo()
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")


func _on_nigeru_pressed():
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")

