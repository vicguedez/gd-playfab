extends RefCounted
class_name PlayFabUtils

static func array_convert_models_to_dictionary(array: Array, model_keys_pascal_case := false, model_only_dirty_props := false) -> Array:
	var new_array := []
	
	for value in array:
		var value_type := typeof(value)
		var new_value
		
		if value is PlayFabEconomyModel.InventoryItemsOperation:
			new_value = {}
			new_value[value.get_type()] = value.to_dictionary(model_keys_pascal_case, model_only_dirty_props)
		elif value is PlayFabModel:
			new_value = value.to_dictionary(model_keys_pascal_case, model_only_dirty_props)
		elif value_type == TYPE_ARRAY:
			new_value = array_convert_models_to_dictionary(value, model_keys_pascal_case, model_only_dirty_props)
		elif value_type == TYPE_DICTIONARY:
			new_value = dictionary_convert_models_to_dictionary(value, model_keys_pascal_case, model_only_dirty_props)
		else:
			new_value = value
		
		new_array.append(new_value)
	
	return new_array

static func dictionary_convert_models_to_dictionary(dict: Dictionary, model_keys_pascal_case := false, model_only_dirty_props := false) -> Dictionary:
	var new_dict := {}
	
	for key in dict:
		var value = dict[key]
		var value_type := typeof(value)
		var new_value
		
		if value is PlayFabModel:
			new_value = value.to_dictionary(model_keys_pascal_case, model_only_dirty_props)
		elif value_type == TYPE_ARRAY:
			new_value = array_convert_models_to_dictionary(value, model_only_dirty_props)
		elif value_type == TYPE_DICTIONARY:
			new_value = dictionary_convert_models_to_dictionary(value, model_only_dirty_props)
		else:
			new_value = value
		
		new_dict[key] = new_value
	
	return new_dict
