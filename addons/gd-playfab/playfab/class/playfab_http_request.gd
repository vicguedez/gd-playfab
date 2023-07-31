## Base class for all API calls. Should not be used directly.
extends RefCounted
class_name PlayFabHttpRequest

## Same signal as HTTPRequest.request_completed.
signal completed(result: HTTPRequest.Result, response_code: int, headers: PackedStringArray, body: PackedByteArray)
## Emitted after completed, passes itself as an argument.
signal finished(request)

const SUCCESS_CODES = [
	HTTPClient.RESPONSE_OK,
	HTTPClient.RESPONSE_NO_CONTENT,
	]
const ERROR_CODES = [
	HTTPClient.RESPONSE_BAD_REQUEST,
	HTTPClient.RESPONSE_UNAUTHORIZED,
	]

## API endpoint. Do not modify unless you know what you are doing.
var api_url = "playfabapi.com"
## Do not use unless you know what you are doing.
var http: HTTPRequest

var _requesting = false
var _completed = {}

func _init() -> void:
	http = PlayFab.get_http()
	
	set("title_id", PlayFabSettings.title_id)

func _notification(what: int) -> void:
	if what != NOTIFICATION_PREDELETE:
		return
	
	PlayFab.recycle_http(http)

## Returns a Dictionary with the configuration data for this request.
func get_config() -> Dictionary:
	return {}

## Returns target path for this request. Default [code]"/"[/code].
func get_path() -> String:
	return get_config().get("path", "/")

## Returns http method for this request. Default [enum HTTPClient.METHOD_POST].
func get_method() -> HTTPClient.Method:
	return get_config().get("method", HTTPClient.METHOD_POST)

## Returns data fields for this request. Default [code]{}[/code]
func get_fields() -> Dictionary:
	return get_config().get("fields", {})

## Returns required fields for this request. Default [code][][/code].
func get_required_fields() -> Array:
	return get_config().get("required_fields", [])

## Returns required headers for this request. Default [code][][/code].
func get_required_headers() -> Array:
	return get_config().get("required_headers", [])

## Returns known success codes for this request. Default [constant SUCCESS_CODES].
func get_success_codes() -> Array:
	return SUCCESS_CODES

## Returns known error codes for this request. Default [constant ERROR_CODES].
func get_error_codes() -> Array:
	return ERROR_CODES

## Returns request's result. Default [code]-1[/code].
func get_request_result() -> HTTPRequest.Result:
	return _completed.get("result", -1)

## Returns response's http code. Default [code]-1[/code].
func get_response_code() -> int:
	return _completed.get("code", -1)

## Returns response's http headers. Default [code][][/code].
func get_response_headers() -> PackedStringArray:
	return _completed.get("headers", PackedStringArray([]))

## Returns response's raw body. Default [code][][/code].
func get_response_body() -> PackedByteArray:
	return _completed.get("body", PackedByteArray([]))

## Returns response's error if any. Default [code]null[/code].
func get_response_error() -> PlayFabModel.ApiErrorWrapper:
	return _completed.get("error", null)

## Returns response's data model if any. Default [code]null[/code].
func get_response_data():
	return _completed.get("data", null)

## Returns true if the response is expected. Default [code]false[/code].
func is_response_expected() -> bool:
	return _completed.get("expected", false)

## Returns true if the response was an error. Default [code]false[/code].
func is_response_error() -> bool:
	return _completed.has("error")

## Utility method to check for errors after the request has finished. Checks that [method get_request_result] returns [enum HTTPRequest.RESULT_SUCCESS], [method is_response_error] returns [code]false[/code] and [method is_response_expected] returns [code]true[/code].
func has_error() -> bool:
	return (
		get_request_result() != HTTPRequest.RESULT_SUCCESS
		or is_response_error() == true
		or is_response_expected() == false
	)

## Sends the request. Returns a value from [enum @GlobalScope.Error], [code]FAILED[/code] if a required field is not set, [code]OK[/code] on success.
func send() -> Error:
	if not _check_required_fields():
		return FAILED
	
	var keys_pascal_case = true
	var method = get_method()
	var data = ""
	
	if method == HTTPClient.METHOD_POST:
		data = JSON.stringify(_get_fields_as_dictionary(keys_pascal_case))
	
	var url = "https://%s.%s%s" % [PlayFabSettings.title_id, api_url, get_path()]
	var headers = [
		"Content-Type: application/json",
		"Content-Length: %s" % data.length()
	]
	
	for header in get_required_headers():
		if header == "X-EntityToken":
			headers.append("X-EntityToken: %s" % PlayFabSettings.authentication_context.entity_token)
		elif header == "X-SecretKey":
			headers.append("X-SecretKey: %s" % PlayFabSettings.authentication_context.secret_key)
	
	var attempt = http.request(url, PackedStringArray(headers), method, data)
	
	if not attempt == OK:
		return attempt
	
	_requesting = true
	reference()
	
	http.request_completed.connect(_on_request_completed, CONNECT_ONE_SHOT)
	
	return OK

func _check_required_fields() -> bool:
	for field in get_required_fields():
		var value = get(field)
		
		if (
				typeof(value) == TYPE_NIL
				|| (typeof(value) == TYPE_FLOAT and is_equal_approx(value, 0))
				|| (typeof(value) == TYPE_INT and value == 0)
				|| (typeof(value) == TYPE_STRING and value.is_empty())
				|| (typeof(value) == TYPE_DICTIONARY and value.is_empty())
				|| (typeof(value) == TYPE_ARRAY and value.is_empty())
			):
			
			if field == "title_id":
				push_error("A title_id must be set on PlayFab.Settings for http requests to work.")
			
			return false
	
	return true

func _get_fields_as_dictionary(keys_pascal_case = false) -> Dictionary:
	var dict = {}
	var fields = get_fields()
	var required = get_required_fields()
	
	for key in fields:
		var value = fields[key]
		var value_type = typeof(value)
		var new_value
		
		if value is PlayFabModel:
			if key in required or value.is_dirty():
				new_value = value.to_dictionary(keys_pascal_case)
		elif value_type == TYPE_ARRAY:
			new_value = PlayFabUtils.array_convert_models_to_dictionary(value, keys_pascal_case)
		elif value_type == TYPE_DICTIONARY:
			new_value = PlayFabUtils.dictionary_convert_models_to_dictionary(value, keys_pascal_case)
		else:
			new_value = value
		
		if keys_pascal_case:
			key = key.to_pascal_case()
		
		dict[key] = new_value
	
	return dict

func _new_result_model():
	return PlayFabModel.new()

func _on_request_completed(result: HTTPRequest.Result, code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	_requesting = false
	_completed = {
		"result": result,
		"code": code,
		"headers": headers,
		"body": body,
	}
	
	var body_dict = JSON.parse_string(body.get_string_from_utf8())
	var dict_is_body_response = true
	
	if get_success_codes().has(code):
		_completed["expected"] = true
		
		var model = _new_result_model()
		
		if body_dict:
			model.parse_dictionary(body_dict.get("data", {}), dict_is_body_response)
		
		_completed["data"] = model
	elif get_error_codes().has(code):
		var error = PlayFabModel.ApiErrorWrapper.new()
		
		if body_dict:
			error.parse_dictionary(body_dict, dict_is_body_response)
		
		_completed["error"] = error
	
	completed.emit(result, code, headers, body)
	finished.emit(self)
	
	unreference.call_deferred()
