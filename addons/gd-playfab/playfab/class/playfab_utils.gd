extends RefCounted
class_name PlayFabUtils

static func array_convert_models_to_dictionary(array: Array, keys_pascal_case = false) -> Array:
	var new_array = []
	
	for value in array:
		var value_type = typeof(value)
		var new_value
		
		if value is PlayFabModel:
			new_value = value.to_dictionary(keys_pascal_case)
		elif value_type == TYPE_ARRAY:
			new_value = array_convert_models_to_dictionary(value, keys_pascal_case)
		elif value_type == TYPE_DICTIONARY:
			new_value = dictionary_convert_models_to_dictionary(value, keys_pascal_case)
		else:
			new_value = value
		
		new_array.append(new_value)
	
	return new_array

static func dictionary_convert_models_to_dictionary(dict: Dictionary, keys_pascal_case = false) -> Dictionary:
	var new_dict = {}
	
	for key in dict:
		var value = dict[key]
		var value_type = typeof(value)
		var new_value
		
		if value is PlayFabModel:
			new_value = value.to_dict()
		elif value_type == TYPE_ARRAY:
			new_value = array_convert_models_to_dictionary(value)
		elif value_type == TYPE_DICTIONARY:
			new_value = dictionary_convert_models_to_dictionary(value)
		else:
			new_value = value
		
		if keys_pascal_case:
			key = key.to_pascal_case()
		
		new_dict[key] = new_value
	
	return new_dict
