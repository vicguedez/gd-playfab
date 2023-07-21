@tool
extends Control

const LINES_TO_IGNORE = [
	"Name 	Type 	Description",
	"Name 	Required 	Type 	Description",
	]

enum Extend {
	STANDALONE,
	PLAYFABMODEL,
	PLAYFABHTTPREQUEST
}

@onready
var input: TextEdit = $container/input
@onready
var output: TextEdit = $container/output

@onready
var input_clear: Button = $container/input_h_container/clear

@onready
var output_extend: OptionButton = $container/output_h_container/extend
@onready
var output_copy: Button = $container/output_h_container/copy

func _ready() -> void:
	input.text_changed.connect(_on_input_text_changed)
	input_clear.pressed.connect(_on_input_clear_pressed)
	
	output_extend.item_selected.connect(_on_output_extend_item_selected)
	output_copy.pressed.connect(_on_output_copy_pressed)

func _on_input_clear_pressed() -> void:
	input.clear()
	output.clear()

func _on_output_extend_item_selected(_index: int) -> void:
	_on_input_text_changed()

func _on_output_copy_pressed() -> void:
	if output.text.is_empty():
		return
	
	output.select_all()
	output.copy()
	output.deselect()
	
	input.clear()
	output.clear()

func _on_input_text_changed() -> void:
	output.clear()
	
	if input.text.is_empty():
		return
	
	var input_text = RegEx.create_from_string("(\\ \\t\\t\\n\\n|\\ \\t\\n\\n|\\n\\t\\n\\n|\\n\\t)").sub(input.text.strip_edges(), "\t", true)
	var lines: PackedStringArray = input_text.split("\n", false)
	var first_line = true;
	
	var _extend_model = false
	var _extend_httprequest = false
	var _extends = ""
	var _fields = []
	var _required_fields = []
	
	match output_extend.get_selected_id():
		Extend.PLAYFABMODEL:
			_extend_model = true
			_extends = " extends PlayFabModel"
		Extend.PLAYFABHTTPREQUEST:
			_extend_httprequest = true
			_extends = " extends PlayFabHttpRequest"
		_:
			pass
	
	while lines.size():
		if first_line:
			var _class = "class %s%s:\n" % [lines[0], _extends]
			
			lines.remove_at(0)
			
			var _desc = lines[0]
			
			lines.remove_at(0)
			
			if LINES_TO_IGNORE.has(lines[0]):
				lines.remove_at(0)
			
			if not LINES_TO_IGNORE.has(_desc):
				output.insert_text_at_caret("## %s\n" % _desc)
			
			output.insert_text_at_caret(_class)
			
			first_line = false
			
			continue
		
		var next_line = lines[0]
		
		lines.remove_at(0)
		
		var line_parts: PackedStringArray = next_line.strip_edges().split("\t", false)
		var key = line_parts[0].to_snake_case().trim_suffix("_")
		
		_fields.append(key)
		
		if line_parts.size() > 3:
			if line_parts[1] == "True":
				_required_fields.append(key)
			
			line_parts.remove_at(1)
		
		var type = line_parts[1]
		var type_initialize = false
		var description = line_parts[2] if line_parts.size() > 2 else ""
		var initialize = ""
		
		if type.begins_with("string"):
			type = type.replace("string", "String")
		elif type.begins_with("boolean"):
			type = type.replace("boolean", "bool")
		elif type.begins_with("object"):
			type = type.replace("object", "Dictionary")
			type_initialize = true
		elif type.begins_with("number"):
			type = type.replace("number", "float")
		elif type.begins_with("integer"):
			type = type.replace("integer", "int")
		else:
			if _extend_httprequest:
				type = "PlayFabModel.%s" % type
			
			type_initialize = true
		
		if type.ends_with("[]"):
			type = "Array[%s]" % type.substr(0, type.length() - 2)
		
		if not description.is_empty():
			if not description.ends_with("."):
				description += "."
			
			output.insert_text_at_caret("\t## %s\n" % description)
		
		if (
				_extend_httprequest
				and type_initialize
			):
			
			if type.begins_with("Array["):
				initialize = " = []"
			elif type == "Dictionary":
				initialize = " = {}"
			else:
				initialize = " = %s.new()" % type
		
		output.insert_text_at_caret("\tvar %s: %s%s\n" % [key, type, initialize])
	
	if (_extend_httprequest):
		output.insert_text_at_caret("\t\n\tfunc get_config() -> Dictionary:\n")
		output.insert_text_at_caret("\t\treturn {\n")
		output.insert_text_at_caret('\t\t\t"fields": {\n')
		
		for field in _fields:
			output.insert_text_at_caret('\t\t\t\t"%s": %s,\n' % [field, field])
		
		output.insert_text_at_caret('\t\t\t},\n')
		output.insert_text_at_caret('\t\t\t"required_fields": %s,\n' % JSON.stringify(_required_fields))
		output.insert_text_at_caret("\t\t}\n")
	
	output.insert_text_at_caret("\n")
