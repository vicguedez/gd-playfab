## Base class for all API calls. Should not be used directly.
extends RefCounted
class_name PlayFabHttpRequest

## API endpoint. Do not modify unless you know what you are doing.
var api_url = "playfabapi.com"
## Do not use unless you know what you are doing.
var http: HTTPRequest

func _init() -> void:
	http = PlayFab.get_http()
	
	set("title_id", PlayFab.Settings.title_id)

func _notification(what: int) -> void:
	if what != NOTIFICATION_PREDELETE:
		return
	
	PlayFab.recycle_http(http)

## Returns a Dictionary with the configuration data for this request.
func get_config() -> Dictionary:
	return {}

## Returns target path for this request. Default "/".
func get_path() -> String:
	return get_config().get("path", "/")

## Returns http method for this request. Default POST.
func get_method() -> HTTPClient.Method:
	return get_config().get("method", HTTPClient.METHOD_POST)

## Returns data fields for this request. Default {}
func get_fields() -> Dictionary:
	return get_config().get("fields", {})

## Returns required fields for this request. Default [].
func get_required_fields() -> Array[String]:
	return get_config().get("required_fields", [])

func send() -> Error:
	if not _check_required_fields():
		return ERR_INVALID_DATA
	
	var url = "https://%s.%s%s" % [PlayFab.Settings.title_id, api_url, get_path()]
	var request_result = http.request(url, PackedStringArray(), get_method())
	
	if not request_result == OK:
		return request_result
	
	return OK

func _check_required_fields() -> bool:
	for field in get_required_fields():
		var value = get(field)
		
		if (
				typeof(value) == TYPE_NIL
				|| (typeof(value) == TYPE_STRING and value.is_empty())
				|| (typeof(value) == TYPE_DICTIONARY and value.is_empty())
				|| (typeof(value) == TYPE_ARRAY and value.is_empty())
			):
			
			return false
	
	return true

func _get_fields_as_dictionary() -> Dictionary:
	var dict = {}
	var fields = get_fields()
	
	for key in fields:
		var value = fields[key]
		var value_type = typeof(value)
		var new_value = value
		
		if value is PlayFabModel:
			new_value = value.to_dictionary()
		elif value_type == TYPE_ARRAY:
			new_value = PlayFabUtils.array_convert_models_to_dictionary(value)
		elif value_type == TYPE_DICTIONARY:
			new_value = PlayFabUtils.dictionary_convert_models_to_dictionary(value)
		
		dict[key] = value
	
	return {}
