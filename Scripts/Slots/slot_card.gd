extends TextureRect

@export var fields : Array[RichTextLabel]
var _fieldIndex : int = 0
var _prevText : String = "[font_size=14][outline_size=7][outline_color=black][p align=center][b]"

func _ready():
	clear_values()
	pass

func clear_values():
	for field in fields:
		field.text = _prevText
	pass

func add_values(category, value):
	fields[_fieldIndex].text = _prevText+category+" "+value
	_fieldIndex+=1
	if (_fieldIndex >= fields.size()):
		_fieldIndex = 0
