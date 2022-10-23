extends Control

const namae = "ゴブリン"
const area = "sougen"
const hu_love := 10
const mo_love := 10
const attack := 2500
const defense := 2500
const love_pw := 70
const max_hp := 5000

onready var sentou = $sentou
onready var koudou = $koudou
onready var aisatu = $koudou/aisatu
onready var kaiwa = $koudou/kaiwa
onready var okurimono = $koudou/okurimono
onready var batou = $koudou/batou
onready var kakunin = $kakunin
onready var nigeru = $nigeru
onready var bunsyo = $Panel/message

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

var p_love : int = 30
var hp := 5000
var count = 0
var damage_count = 0
var kill_count = 0
var dati_count = 0
var dmg = {
	"name" : namae,
	"p_love" : p_love,
	"kill_count" : kill_count,
	"dati_count" : dati_count
}


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
	Player._load_suruyo()
	_load_suruyo()
	$ColorRect/name.text = namae
	bunsyo.text = namae + "と出会った。\nどうする？"
	if kill_count >= 1 or p_love <= 10:
			kougekisareru()
			saisyokara()
	else:
		saisyonogamen()

func saisyonogamen():
	mon_kankei()
	hu_kankei()
	p_kankei()
	if count >= 3:
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
	pass

func _on_koudou_toggled(_on_koudou_pressed):
	if(_on_koudou_pressed):
		aisatu.show()
		kaiwa.show()
		okurimono.show()
		batou.show()
		$sentou/kill.hide()
		$sentou/utinomesu.hide()
		$saikindo.hide()
		$tomodati.hide()
		$tugihe.hide()
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

func _on_aisatu_pressed():
	var _word = ["こんにちは！いい天気ですね！", "わぁ、人間さんだ。こんにちは！", "こんにちは！"]
	var _word2 = ["おや、また会いましたね。こんにちは！", _p_name + "さん、こんにちは！"]
	var _word3 = ["…私に何か用ですか…？", "えっ…こ、こんにちは…", "あっ…どうも…"]
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
		_p_mo_love = (_p_mo_love + mo_love)
		_p_hu_love= (_p_hu_love - hu_love)
		count += 1
	elif damage_count >= 1 or kill_count >= 1:
		bunsyo.text = _random_word3
		p_love = (p_love + 3)
		_p_mo_love = (_p_mo_love + mo_love)
		_p_hu_love= (_p_hu_love - hu_love)
		count += 1
	else:
		bunsyo.text = _random_word
		p_love = (p_love + 3)
		_p_mo_love = (_p_mo_love + mo_love)
		_p_hu_love= (_p_hu_love - hu_love)
		count += 1
	return saisyonogamen()


func _on_kaiwa_pressed():
	sentou.hide()
	koudou.hide()
	kakunin.hide()
	nigeru.hide()
	$saikindo.show()


func _on_sentou_pressed():
	pass

func _on_sentou_toggled(_on_sentou_pressed):
	if(_on_sentou_pressed):
		aisatu.hide()
		kaiwa.hide()
		okurimono.hide()
		batou.hide()
		$saikindo.hide()
		$tomodati.hide()
		$tugihe.hide()
		$modoru.hide()
		$sentou/kill.show()
		$sentou/utinomesu.show()
	else:
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


func _on_kakunin_pressed():
	pass

func _on_kakunin_toggled(_on_kakunin_pressed):
	if(_on_kakunin_pressed):
		$kakunin/kakunin_kontena.show()
		$kakunin/kakunin_sita.show()
	else:
		$kakunin/kakunin_sita.hide()
		$kakunin/kakunin_kontena.hide()


func _on_saikindo_pressed():
	var _word = [_p_name + "さんとお話しできて嬉しいです！", "今日はパンが美味しく焼けたんですよ！", _p_name + "さんは怖くないですが…\n他の人間さんもお見かけすると、\nちょっと怖いです。"]
	var _word2 = ["えっ…まあ…そこそこ…", "あなたにお伝えする事はありません", "ひぃっ！"]
	var _word3 = ["んー、どうなんでしょう？\nまぁ、いつも通りですよ", "今日を生きるだけで精一杯ですね、\nあははっ", "最近…\n…まぁまぁってとこですかね"]
	var _ran_w = _word[randi() % _word.size()]
	var _ran_w2 = _word2[randi() % _word2.size()]
	var _ran_w3 = _word3[randi() % _word3.size()]
	var random = randf()
	if damage_count >= 1 or kill_count >= 1:
		bunsyo.text = _ran_w2
		p_love = (p_love + 2)
		_p_mo_love = (_p_mo_love + (mo_love - 7))
		_p_hu_love = (_p_hu_love - hu_love)
		count += 1
	elif p_love >= 50:
		if random < 0.8:
			bunsyo.text = _ran_w
			p_love = (p_love + 8)
			_p_mo_love = (_p_mo_love + (mo_love - 5))
			_p_hu_love = (_p_hu_love - hu_love)
			count += 1
		else:
			var kane = randi() % 510 + 10
			_p_kane = _p_kane + kane
			bunsyo.text = _p_name + "さん、これどうぞ！\n-" + namae + "から手渡された袋には" + kane + "が入っていましたよ -\n- ラッキー！ -"
	else:
		bunsyo.text = _ran_w3
		p_love = (p_love + 5)
		_p_mo_love = (_p_mo_love + (mo_love - 5))
		_p_hu_love = (_p_hu_love - hu_love)
		count += 1
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
	_p_dati.append(namae)
	dati_count += 1
	Player._save_suruyo()
	_save_suruyo()
	if damage_count == 0:
		bunsyo.text = "勿論！\n" + _p_name + "さんとお友達になれて、とっても嬉しいです！\nこれからもよろしくお願いします！"
	else:
		bunsyo.text = _p_name + "さん…\nもう…あんな事…しないですよね…？\n…信じます…ね…。" 


func _on_kill_pressed():
	hp = hp - ((defense - _p_attack) + p_love) * 100
	p_love = (p_love - 20)
	_p_hu_love = (_p_hu_love + hu_love)
	_p_mo_love = (_p_mo_love - mo_love)
	_p_attack = (_p_attack + randi() % 10)
	_p_defense = (_p_defense + randi() % 10)
	count += 1
	damage_count += 1
	var _word = ["酷い！何するんですか！", "痛い！やめてください！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		bunsyo.text = ran_word
		saisyonogamen()
	else:
		dead()


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
	bunsyo.text = "ひ…酷い…痛い…"
	p_love = 0
	_p_hu_love = (_p_hu_love - hu_love)
	_p_mo_love = (_p_mo_love - mo_love)
	damage_count += 1
	kill_count += 1
	_p_kill.append(namae)
	Player._save_suruyo()
	_save_suruyo()


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
	if _p_mo_love >= 350:
		$ColorRect2/mon_zyoutai2.text = "イイ感じ"
	elif _p_mo_love <= 349 and _p_mo_love >= 100:
		$ColorRect2/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect2/mon_zyoutai2.text = "ヤバい感じ"

func hu_kankei():
	if _p_hu_love >= 350:
		$ColorRect2/hu_zyoutai2.text  = "イイ感じ"
	elif _p_hu_love <= 349 and _p_hu_love >= 100:
		$ColorRect2/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect2/hu_zyoutai2.text = "ヤバい感じ"

func p_kinryoku():
	if _p_attack >= 500:
		$ColorRect2/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif _p_attack <= 499 and _p_attack >= 200:
		$ColorRect2/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect2/kinryoku_suuzi.text = "普通"

func p_taisei():
	if _p_defense >= 500:
		$ColorRect2/taisei_suuzi.text  = "金属"
	elif _p_defense <= 499 and _p_defense >= 200:
		$ColorRect2/taisei_suuzi.text = "布"
	else:
		$ColorRect2/taisei_suuzi.text = "紙"

func p_tairyoku():
	if _p_hp >= 5000:
		$ColorRect2/tairyoku_suuzi.text  = "超人"
	elif _p_hp <= 4999 and _p_hp >= 2000:
		$ColorRect2/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect2/tairyoku_suuzi.text = "常人"


func _on_utinomesu_pressed():
	hp = hp - ((defense - _p_attack) + p_love)
	p_love = (p_love - 10)
	_p_hu_love = (_p_hu_love + hu_love)
	_p_mo_love = (_p_mo_love - mo_love)
	_p_attack = (_p_attack + randi() % 5)
	_p_defense = (_p_defense + randi() % 5)
	count += 1
	damage_count += 1
	var _word = ["えっ…", "えっ…なんですか…？", "やめてください！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		bunsyo.text = ran_word
		saisyonogamen()
	else:
		dead()


func _on_batou_pressed():
	var _word = ["…あなたは酷い人間だ…", "やっぱり人間は酷い生き物なんですね", "(早く酷い人間が来たってオーガさんに報告しなきゃ…)"]
	var _word2 = ["えっ…" + _p_name + "さん…\n急にどうしたんですか…？", _p_name + "さん…じょ、冗談きついですよー…"]
	var _word3 = ["ちょっと、何なんですか", "…そんな事言わなくても…", "………"]
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
		_p_mo_love = (_p_mo_love - 3)
		_p_hu_love= (_p_hu_love + hu_love)
		count += 1
		damage_count += 1
	elif p_love >= 10 and p_love <= 49:
		bunsyo.text = _random_word3
		p_love = (p_love - 3)
		_p_mo_love = (_p_mo_love - 3)
		_p_hu_love= (_p_hu_love + hu_love)
		count += 1
		damage_count += 1
	else:
		bunsyo.text = _random_word
		p_love = (p_love - 3)
		_p_mo_love = (_p_mo_love - 3)
		_p_hu_love= (_p_hu_love + hu_love)
		count += 1
		damage_count += 1
	return saisyonogamen()

func saisyokara():
	hp = max_hp
	count = 0
	damage_count = 0


func _on_modoru_pressed():
	Player._save_suruyo()
	_save_suruyo()
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")


func _on_nigeru_pressed():
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")


func _save_suruyo():
	var _file = File.new()
	_file.open("user://dmg.save",File.WRITE)
	_file.store_var(dmg, true)
	_file.close()

func _load_suruyo():
	var _file = File.new()
	if not _file.file_exists("user://dmg.save"):
		return _save_suruyo()
	_file.open("user://dmg.save",File.READ)
	dmg = _file.get_var(true)
	if typeof(dmg) == TYPE_DICTIONARY:
		p_love = dmg.p_love
		kill_count = dmg.kill_count
		dati_count = dmg.dati_count
	else:
		printerr("nakattayo")
	_file.close()

func kougekisareru():
	_p_hp = _p_hp - ((attack - _p_defense) / randi() % 10)
	if _p_hp <= 0:
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
			$modoru.hide()
			$kyoten.show()
			bunsyo.text = "- あなたは死んでしまいました -\n- 次は頑張ってください！ -"
	else:
		saisyonogamen()


func _on_kyoten_pressed():
	return get_tree().change_scene("res://scene/kyotenti.tscn")


