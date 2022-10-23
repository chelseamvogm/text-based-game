extends Node

var _p_name = "sinzin"
var _p_attack : int = 10
var _p_defense : int = 10
var _p_kane : int = 0
var _p_hu_love : int = 0
var _p_mo_love : int = 0
var _p_hp : int = 100
var _p_dati = []
var _p_kill = []

var _playerdata = {}

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

func _save_suruyo():
	var _file = File.new()
	_save_datadayo()
	_file.open(_savefile,File.WRITE)
	_file.store_var(_playerdata, true)
	_file.close()

func _load_suruyo():
	var _file = File.new()
	if not _file.file_exists("user://kimi.save"):
		return _save_suruyo()
	_file.open(_savefile,File.READ)
	_playerdata = _file.get_var(true)
	if typeof(_playerdata) == TYPE_DICTIONARY:
		_p_name = _playerdata.p_name
		_p_hp = _playerdata.p_hp
		_p_attack = _playerdata.p_attack
		_p_defense = _playerdata.p_defense
		_p_kane = _playerdata.p_kane
		_p_hu_love = _playerdata.p_hu_love
		_p_mo_love = _playerdata.p_mo_love
		_p_dati = _playerdata.p_dati
		_p_kill = _playerdata.p_kill
	else:
		printerr("nakattayo")
	_file.close()

