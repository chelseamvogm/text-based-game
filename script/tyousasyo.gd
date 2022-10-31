extends Control

var gob_no : bool = false

func _ready():
	Player._load_suruyo()


func _on_modoru_pressed():
	pass


func _on_gob_no_pressed():
	$gob_no.show()
	$kou_no.hide()
	if gob_no == false and "ゴブリン" in Player._p_mon_dati:
		$gob_no/tairyoku2.text = str(MonDatabase._monster_zyouhou("ゴブリン").hp)
		$gob_no/kinryoku2.text = str(MonDatabase._monster_zyouhou("ゴブリン").attack)
		$gob_no/taisei2.text = str(MonDatabase._monster_zyouhou("ゴブリン").defense)
		$gob_no/kannkei2.text = "友達"
		$gob_no/tuiki.text = MonDatabase._monster_zyouhou("ゴブリン").setumei_dati
		gob_no = true
	elif gob_no == false and "ゴブリン" in Player._p_mon_kill:
		$gob_no/tairyoku2.text = str(MonDatabase._monster_zyouhou("ゴブリン").hp)
		$gob_no/kinryoku2.text = str(MonDatabase._monster_zyouhou("ゴブリン").attack)
		$gob_no/taisei2.text = str(MonDatabase._monster_zyouhou("ゴブリン").defense)
		$gob_no/kannkei2.add_color_override("font_color", Color(0.803922, 0.360784, 0.360784, 1))
		$gob_no/kannkei2.text = "討伐完了"
		$gob_no/tuiki.add_color_override("default_color", Color(0.803922, 0.360784, 0.360784, 1))
		$gob_no/tuiki.text = MonDatabase._monster_zyouhou("ゴブリン").setumei_kill
		gob_no = true
	else:
		pass


func _on_kou_no_pressed():
	$gob_no.hide()
	$kou_no.show()

