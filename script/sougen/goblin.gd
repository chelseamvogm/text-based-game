extends Control

var namae = MonDatabase._monster_zyouhou("ゴブリン").namae
var area = MonDatabase._monster_zyouhou("ゴブリン").area
var hu_love = MonDatabase._monster_zyouhou("ゴブリン").hu_love
var mo_love = MonDatabase._monster_zyouhou("ゴブリン").mo_love
var attack = MonDatabase._monster_zyouhou("ゴブリン").attack
var defense = MonDatabase._monster_zyouhou("ゴブリン").defense
var love_pw = MonDatabase._monster_zyouhou("ゴブリン").love_pw
var max_hp = MonDatabase._monster_zyouhou("ゴブリン").hp
var saisyo_p_love = MonDatabase._monster_zyouhou("ゴブリン").saisyo_p_love

var p_love : int
var hp : int = 5000
var count = 0
var damage_count = 0
var kill_count = 0
var dati_count = 0
var ima_kill = 0
var kane : int


func _save_suruyo():
	var dmg = {
		"name" : namae,
		"p_love" : p_love,
		"kill_count" : kill_count,
		"dati_count" : dati_count
		}
	var _file = File.new()
	_file.open("user://dmg.save",File.WRITE)
	_file.store_var(dmg, true)
	_file.close()

func _load_suruyo():
	var dmg = {
		"name" : namae,
		"p_love" : p_love,
		"kill_count" : kill_count,
		"dati_count" : dati_count
		}
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
		_save_suruyo()
	_file.close()


func _mon_kankei():
	if Player._p_mo_love >= 350:
		$ColorRect2/mon_zyoutai2.text = "イイ感じ"
	elif Player._p_mo_love <= 349 and Player._p_mo_love >= 100:
		$ColorRect2/mon_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect2/mon_zyoutai2.text = "ヤバい感じ"

func _hu_kankei():
	if Player._p_hu_love >= 350:
		$ColorRect2/hu_zyoutai2.text  = "イイ感じ"
	elif Player._p_hu_love <= 349 and Player._p_hu_love >= 100:
		$ColorRect2/hu_zyoutai2.text = "そこそこな感じ"
	else:
		$ColorRect2/hu_zyoutai2.text = "ヤバい感じ"

func _p_kinryoku():
	if Player._p_attack >= 500:
		$ColorRect2/kinryoku_suuzi.text  = "ゴリマッチョ"
	elif Player._p_attack <= 499 and Player._p_attack >= 200:
		$ColorRect2/kinryoku_suuzi.text = "細マッチョ"
	else:
		$ColorRect2/kinryoku_suuzi.text = "普通"

func _p_taisei():
	if Player._p_defense >= 500:
		$ColorRect2/taisei_suuzi.text  = "金属"
	elif Player._p_defense <= 499 and Player._p_defense >= 200:
		$ColorRect2/taisei_suuzi.text = "布"
	else:
		$ColorRect2/taisei_suuzi.text = "紙"

func _p_tairyoku():
	if Player._p_hp >= 5000:
		$ColorRect2/tairyoku_suuzi.text  = "超人"
	elif Player._p_hp <= 4999 and Player._p_hp >= 2000:
		$ColorRect2/tairyoku_suuzi.text = "強人"
	else:
		$ColorRect2/tairyoku_suuzi.text = "常人"


func _p_kankei():
	if p_love >= love_pw:
		$ColorRect/dou.text = "???"
		$Panel/message.text = "………"
	elif p_love <= love_pw and p_love >= 35:
		$ColorRect/dou.text = "知り合い"
	else:
		$ColorRect/dou.text = "初対面"


func saisyonogamen():
	_p_kankei()
	_mon_kankei()
	_hu_kankei()
	_p_tairyoku()
	_p_kinryoku()
	_p_taisei()
	Player._save_suruyo()
	Player._load_suruyo()
	if count >= 3:
		$sentou.hide()
		$koudou.hide()
		$kakunin.hide()
		$nigeru.hide()
		$aisatu.hide()
		$kaiwa.hide()
		$batou.hide()
		$kill.hide()
		$utinomesu.hide()
		$saikindo.hide()
		$dati.hide()
		$tugihe.show()
		$ikkai_modoru.hide()
	elif p_love >= love_pw:
		$sentou.hide()
		$koudou.hide()
		$kakunin.hide()
		$nigeru.hide()
		$aisatu.hide()
		$kaiwa.hide()
		$batou.hide()
		$kill.hide()
		$utinomesu.hide()
		$saikindo.hide()
		$dati.show()
		$tugihe.hide()
		$ikkai_modoru.hide()
	else:
		$sentou.show()
		$koudou.show()
		$kakunin.show()
		$nigeru.show()
		$aisatu.hide()
		$kaiwa.hide()
		$batou.hide()
		$kill.hide()
		$utinomesu.hide()
		$saikindo.hide()
		$dati.hide()
		$tugihe.hide()
		$ikkai_modoru.hide()
	return


func kougekisareru():
	Player._p_hp = Player._p_hp - ((attack - Player._p_defense) / randi() % 10)
	if Player._p_hp <= 0:
		$sentou.hide()
		$koudou.hide()
		$kakunin.hide()
		$nigeru.hide()
		$aisatu.hide()
		$kaiwa.hide()
		$batou.hide()
		$kill.hide()
		$utinomesu.hide()
		$saikindo.hide()
		$dati.hide()
		$ikkai_modoru.hide()
		$kyoten.show()
		$Panel/message.text = "- あなたは死んでしまいました -\n- 次は頑張ってください！ -"
	else:
		saisyonogamen()


func saisyokara():
	p_love = saisyo_p_love
	hp = max_hp
	count = 0
	damage_count = 0
	saisyonogamen()


func _ready():
	randomize()
	_p_kankei()
	_mon_kankei()
	_hu_kankei()
	_p_tairyoku()
	_p_kinryoku()
	_p_taisei()
	Player._load_suruyo()
	_load_suruyo()
	for y in Player._p_item:
		var but = $PopupPanel/item/ColorRect/ScrollContainer/VBoxContainer/Button.duplicate(8)
		but.add_to_group("item_button")
		but.text = Itemdatabase._item_zyouhou(y)._namae
		but.icon = Itemdatabase._item_zyouhou(y).texture
		$PopupPanel/item/ColorRect/ScrollContainer/VBoxContainer.add_child(but)
	for but in get_tree().get_nodes_in_group("item_button"):
		but.connect("pressed", self, "_some_button_pressed", [but])
	$PopupPanel/item/ColorRect/ScrollContainer/VBoxContainer/Button.hide()
	$ColorRect2/pnamae.text = Player._p_name
	$ColorRect/name.text = namae
	$Panel/message.text = namae + "と出会った。\nどうする？"
	if kill_count >= 1 or p_love <= 10 or dati_count >= 1:
		kougekisareru()
		saisyokara()
	elif p_love >= love_pw:
		saisyokara()
	else:
		saisyonogamen()


func _some_button_pressed(button):
	$PopupPanel.hide()
	$Popup2.hide()
	var _x = button.get_text()
	if Itemdatabase._item_zyouhou(_x)._type == "prezent":
		Itemdatabase._item_ageru(_x)
		p_love = p_love + (Itemdatabase._item_zyouhou(_x)._p_love)
		$aisatu.hide()
		$kaiwa.hide()
		$batou.hide()
		$Panel/message.text = "わぁ！ありがとうございます！"
		count += 1
		saisyonogamen()
	else:
		Itemdatabase._item_tukau(_x)
		$Panel/message.text = "- " + str(_x) + "を使いましたよ -"
		count += 1
		saisyonogamen()


func _on_sentou_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$saikindo.hide()
	$dati.hide()
	$tugihe.hide()
	$ikkai_modoru.hide()
	$kill.show()
	$utinomesu.show()


func _on_kill_pressed():
	hp = hp - ((defense - Player._p_attack) + p_love) * 100
	p_love = (p_love - 20)
	Player._p_hu_love = (Player._p_hu_love + hu_love)
	Player._p_mo_love = (Player._p_mo_love - mo_love)
	Player._p_hp = (Player._p_hp + randi() % 100)
	Player._p_attack = (Player._p_attack + randi() % 10)
	Player._p_defense = (Player._p_defense + randi() % 10)
	count += 1
	damage_count += 1
	var _word = ["酷い！何するんですか！", "痛い！やめてください！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		$Panel/message.text = ran_word
		saisyonogamen()
	else:
		dead()


func _on_utinomesu_pressed():
	hp = hp - ((defense - Player._p_attack) + p_love)
	p_love = (p_love - 10)
	Player._p_hu_love = (Player._p_hu_love + hu_love)
	Player._p_mo_love = (Player._p_mo_love - mo_love)
	Player._p_hp = (Player._p_hp + randi() % 100)
	Player._p_attack = (Player._p_attack + randi() % 5)
	Player._p_defense = (Player._p_defense + randi() % 5)
	count += 1
	damage_count += 1
	var _word = ["えっ…", "えっ…なんですか…？", "やめてください！"]
	var ran_word = _word[randi() % _word.size()]
	if hp <= max_hp and hp >= 0:
		$Panel/message.text = ran_word
		saisyonogamen()
	else:
		dead()


func _on_koudou_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.show()
	$kaiwa.show()
	$batou.show()
	$kill.hide()
	$utinomesu.hide()
	$saikindo.hide()
	$dati.hide()
	$tugihe.hide()
	$ikkai_modoru.hide()


func _on_aisatu_pressed():
	var _word = ["こんにちは！いい天気ですね！", "わぁ、人間さんだ。こんにちは！", "こんにちは！"]
	var _word2 = ["おや、また会いましたね。こんにちは！", Player._p_name + "さん、こんにちは！"]
	var _word3 = ["…私に何か用ですか…？", "えっ…こ、こんにちは…", "あっ…どうも…"]
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	var _random_word = _word[randi() % _word.size()]
	var _random_word2 = _word2[randi() % _word2.size()]
	var _random_word3 = _word3[randi() % _word3.size()]
	if p_love >= 50 and damage_count == 0 and kill_count == 0:
		$Panel/message.text = _random_word2
		p_love = (p_love + 5)
		Player._p_mo_love = (Player._p_mo_love + mo_love)
		Player._p_hu_love= (Player._p_hu_love - hu_love)
		count += 1
	elif damage_count >= 1 or kill_count >= 1:
		$Panel/message.text = _random_word3
		p_love = (p_love + 3)
		Player._p_mo_love = (Player._p_mo_love + mo_love)
		Player._p_hu_love= (Player._p_hu_love - hu_love)
		count += 1
	else:
		$Panel/message.text = _random_word
		p_love = (p_love + 3)
		Player._p_mo_love = (Player._p_mo_love + mo_love)
		Player._p_hu_love= (Player._p_hu_love - hu_love)
		count += 1
	return saisyonogamen()


func _on_kaiwa_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$saikindo.show()
	$dati.hide()
	$tugihe.hide()
	$ikkai_modoru.hide()


func _on_saikindo_pressed():
	var _word = [Player._p_name + "さんとお話しできて嬉しいです！", "今日はパンが美味しく焼けたんですよ！", Player._p_name + "さんは怖くないですが…\n他の人間さんもお見かけすると、ちょっと怖いです。"]
	var _word2 = ["えっ…まあ…そこそこ…", "あなたにお伝えする事はありません", "ひぃっ！"]
	var _word3 = ["んー、どうなんでしょう？\nまぁ、いつも通りですよ", "今日を生きるだけで精一杯ですね、\nあははっ", "最近…\n…まぁまぁってとこですかね"]
	var _ran_w = _word[randi() % _word.size()]
	var _ran_w2 = _word2[randi() % _word2.size()]
	var _ran_w3 = _word3[randi() % _word3.size()]
	var random = randf()
	if damage_count >= 1 or kill_count >= 1:
		$Panel/message.text = _ran_w2
		p_love = (p_love + 2)
		Player._p_mo_love = (Player._p_mo_love + mo_love)
		Player._p_hu_love = (Player._p_hu_love - hu_love)
		count += 1
		return saisyonogamen()
	elif p_love >= 40:
		if random < 0.1:
			$Panel/message.text = _ran_w
			p_love = (p_love + 8)
			Player._p_mo_love = (Player._p_mo_love + 2)
			Player._p_hu_love = (Player._p_hu_love - 2)
			count += 1
			return saisyonogamen()
		elif random < 0.5:
			$Panel/message.text = "今日はパンが美味しく焼けたんですよ！\nおひとつどうぞ！\n- あとで道具を確認しよう！ -"
			Itemdatabase._item_morau("ゴブリンのふかふかパン")
			p_love = (p_love + 3)
			Player._p_mo_love = (Player._p_mo_love + 2)
			Player._p_hu_love = (Player._p_hu_love - 2)
			count += 1
			return saisyonogamen()
		elif random < 0.5:
			$Panel/message.text = "今日はパンが美味しく焼けたんですよ！\nおひとつどうぞ！\n- あとで道具を確認しよう！ -"
			Itemdatabase._item_morau("ゴブリンのカチカチパン")
			p_love = (p_love + 3)
			Player._p_mo_love = (Player._p_mo_love + 2)
			Player._p_hu_love = (Player._p_hu_love - 2)
			count += 1
			return saisyonogamen()
		elif random < 0.5:
			$Panel/message.text = "今日はパンが美味しく焼けたんですよ！\nおひとつどうぞ！\n- あとで道具を確認しよう！ -"
			Itemdatabase._item_morau("ゴブリンのグルグルパン")
			p_love = (p_love + 3)
			Player._p_mo_love = (Player._p_mo_love + 2)
			Player._p_hu_love = (Player._p_hu_love - 2)
			count += 1
			return saisyonogamen()
		else:
			var _kane = randi() % 100
			Player._p_kane = (Player._p_kane + _kane)
			$Panel/message.text = Player._p_name + "さん、これどうぞ！\n- " + namae + "から手渡された袋には" + str(_kane) + "が入っていましたよ -"
			p_love = (p_love + 3)
			Player._p_mo_love = (Player._p_mo_love + 3)
			Player._p_hu_love = (Player._p_hu_love - 3)
			count += 1
			return saisyonogamen()
	else:
		$Panel/message.text = _ran_w3
		p_love = (p_love + 5)
		Player._p_mo_love = (Player._p_mo_love + mo_love)
		Player._p_hu_love = (Player._p_hu_love - hu_love)
		count += 1
	return saisyonogamen()


func _on_dati_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$kill.hide()
	$utinomesu.hide()
	$saikindo.hide()
	$dati.hide()
	$ikkai_modoru.show()
	$ColorRect/dou.text = "友達"
	Player._p_mon_dati.append(namae)
	Player._p_mon_dati_count += 1
	dati_count += 1
	Player._save_suruyo()
	_save_suruyo()
	if damage_count == 0 or kill_count == 0:
		$Panel/message.text = "勿論！\n" + Player._p_name + "さんとお友達になれて、とっても嬉しいです！\nこれからもよろしくお願いします！"
	else:
		$Panel/message.text = Player._p_name + "さん…\nもう…あんな事…しないですよね…？\n…信じます…ね…。" 


func _on_tugihe_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$kill.hide()
	$utinomesu.hide()
	$saikindo.hide()
	$dati.hide()
	$tugihe.hide()
	$ikkai_modoru.show()
	$gazou.hide()
	if ima_kill >= 1:
		$Panel/message.text = "-おめでとう！あなたは戦闘に勝利しました！-\n-この調子で頑張りましょう！-"
	elif count ==3:
		$Panel/message.text = "-" + namae + "は帰っていきました-\n-引き続き調査しましょう！-"


func _on_batou_pressed():
	var _word = ["…あなたは酷い人間だ…", "やっぱり人間は酷い生き物なんですね", "(早く酷い人間が来たって\nオーガさんに報告しなきゃ…)"]
	var _word2 = ["えっ…" + Player._p_name + "さん…\n急にどうしたんですか…？", Player._p_name + "さん…じょ、冗談きついですよー…"]
	var _word3 = ["ちょっと、何なんですか", "…そんな事言わなくても…", "………"]
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	var _random_word = _word[randi() % _word.size()]
	var _random_word2 = _word2[randi() % _word2.size()]
	var _random_word3 = _word3[randi() % _word3.size()]
	if p_love >= 101:
		$Panel/message.text = _random_word2
		p_love = (p_love - 3)
		Player._p_mo_love = (Player._p_mo_love - mo_love)
		Player._p_hu_love= (Player._p_hu_love + hu_love)
		count += 1
		damage_count += 1
	elif p_love >= 49 and p_love <= 100:
		$Panel/message.text = _random_word3
		p_love = (p_love - 3)
		Player._p_mo_love = (Player._p_mo_love - mo_love)
		Player._p_hu_love= (Player._p_hu_love + hu_love)
		count += 1
		damage_count += 1
	else:
		$Panel/message.text = _random_word
		p_love = (p_love - 3)
		Player._p_mo_love = (Player._p_mo_love - mo_love)
		Player._p_hu_love= (Player._p_hu_love + hu_love)
		count += 1
		damage_count += 1
	return saisyonogamen()


func _on_ikkai_modoru_pressed():
	Player._save_suruyo()
	_save_suruyo()
	return get_tree().change_scene("res://scene/sougen/sougen_area.tscn")


func _on_modoru_pressed():
	$Popup.hide()


func _on_nigeru_pressed():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$kill.hide()
	$utinomesu.hide()
	$saikindo.hide()
	$dati.hide()
	$tugihe.hide()
	$ikkai_modoru.show()
	$Panel/message.text = "えっ…？"


func dead():
	$sentou.hide()
	$koudou.hide()
	$kakunin.hide()
	$nigeru.hide()
	$aisatu.hide()
	$kaiwa.hide()
	$batou.hide()
	$kill.hide()
	$utinomesu.hide()
	$saikindo.hide()
	$ikkai_modoru.hide()
	$dati.hide()
	$tugihe.show()
	$Panel/message.text = "ひ…酷い…痛い…"
	p_love = 0
	Player._p_hu_love = (Player._p_hu_love + hu_love)
	Player._p_mo_love = (Player._p_mo_love - mo_love)
	damage_count += 1
	kill_count += 1
	ima_kill += 1
	Player._p_mon_kill.append(namae)
	Player._p_mon_kill_count += 1
	Player._save_suruyo()
	_save_suruyo()


func _on_kakunin_pressed():
	$Popup2.popup()


func _on_kyoten_pressed():
	return get_tree().change_scene("res://scene/kyotenti.tscn")


func _on_status_pressed():
	$status.popup()


func _on_dougu_pressed():
	$PopupPanel.popup()
	$Popup2.hide()


func _on_status_modoru_pressed():
	$status.hide()


