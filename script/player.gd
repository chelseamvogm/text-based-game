extends Node


var _p_name := "sinzin"
var _p_attack : int = 10
var _p_defense : int = 10
var _p_kane : int = 1000
var _p_hu_love : int = 0
var _p_mo_love : int = 0
var _p_hp : int = 100
var _p_mon_dati_count : int = 0
var _p_mon_kill_count : int = 0
var _p_hu_dati_count : int = 0
var _p_hu_kill_count : int = 0
var _p_mon_dati = []
var _p_mon_kill = []
var _p_hu_dati = []
var _p_hu_kill = []
var _p_item = []

var _savefile = "user://kimi.save"
var _playerdata


func _save_suruyo():
	_playerdata = {
		"p_name" : _p_name,
		"p_hp" : _p_hp,
		"p_attack" : _p_attack,
		"p_defense" : _p_defense,
		"p_kane" : _p_kane,
		"p_hu_love" : _p_hu_love,
		"p_mo_love" : _p_mo_love,
		"p_mon_dati_count" : _p_mon_dati_count,
		"p_mon_kill_count" : _p_mon_kill_count,
		"p_hu_dati_count" : _p_hu_dati_count,
		"p_hu_kill_count" : _p_hu_kill_count,
		"p_mon_dati" : _p_mon_dati,
		"p_mon_kill" : _p_mon_kill,
		"p_hu_dati" : _p_hu_dati,
		"p_hu_kill" : _p_hu_kill,
		"p_item" : _p_item
	}
	var _file = File.new()
	_file.open(_savefile,File.WRITE)
	_file.store_var(_playerdata, true)
	_file.close()

func _load_suruyo():
	var _file = File.new()
	if not _file.file_exists("user://kimi.save"):
		return _save_suruyo()
	_file.open(_savefile,File.READ)
	_playerdata = _file.get_var(true)
	_file.close()
	if typeof(_playerdata) == TYPE_DICTIONARY:
		_p_name = _playerdata.p_name
		_p_hp = _playerdata.p_hp
		_p_attack = _playerdata.p_attack
		_p_defense = _playerdata.p_defense
		_p_kane = _playerdata.p_kane
		_p_hu_love = _playerdata.p_hu_love
		_p_mo_love = _playerdata.p_mo_love
		_p_mon_dati_count = _playerdata.p_mon_dati_count
		_p_mon_kill_count = _playerdata.p_mon_kill_count
		_p_hu_dati_count = _playerdata.p_hu_dati_count
		_p_hu_kill_count = _playerdata.p_hu_kill_count
		_p_mon_dati = _playerdata.p_mon_dati
		_p_mon_kill = _playerdata.p_mon_kill
		_p_hu_dati = _playerdata.p_hu_dati
		_p_hu_kill = _playerdata.p_hu_kill
		_p_item = _playerdata.p_item
	else:
		printerr("nakattayo")
		_save_suruyo()


