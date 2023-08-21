## Base class for all API calls. Should not be used directly.
extends RefCounted
class_name PlayFabHttpRequest

## Same signal as HTTPRequest.request_completed.
signal completed(result: HTTPRequest.Result, response_code: int, headers: PackedStringArray, body: PackedByteArray)
## Emitted after completed, passes itself as an argument.
signal finished(request)

enum AuthenticationType {
	NONE,
	ENTITY_TOKEN,
	SESSION_TICKET,
	DEVELOPER_SECRET_KEY,
	}

const SDK_VERSION = "1.0"
const SUCCESS_CODES = [
	HTTPClient.RESPONSE_OK,
	HTTPClient.RESPONSE_NO_CONTENT,
	]
const ERROR_CODES = [
	HTTPClient.RESPONSE_BAD_REQUEST,
	HTTPClient.RESPONSE_UNAUTHORIZED,
	]

## Do not use unless you know what you are doing.
var req_http: HTTPRequest
## API endpoint. Do not modify unless you know what you are doing.
var req_api_url = "playfabapi.com"
## API version.
var req_api_version = "230721"
## Sets the authentication type to be used by this request. Default [enum AuthenticationType.NONE].
var req_authentication_type: AuthenticationType = AuthenticationType.NONE
## Target path for this request. Default [code]"/"[/code].
var req_path = "/"
## Http method for this request. Default [enum HTTPClient.METHOD_POST].
var req_method: HTTPClient.Method = HTTPClient.METHOD_POST
## Data fields for this request. Default [code]{}[/code].
var req_fields: Array = []
## Required fields for this request. Default [code][][/code].
var req_required_fields: Array = []
## Extra headers for this request. Default [code][][/code].
var req_extra_headers: Array = []
## Known success codes for this request. Default [constant SUCCESS_CODES].
var req_success_codes: Array = SUCCESS_CODES.duplicate()
## Known error codes for this request. Default [constant ERROR_CODES].
var req_error_codes: Array = ERROR_CODES.duplicate()

var _requesting = false
var _completed = {}
var _defaults = {}

func _init() -> void:
	req_http = PlayFab.get_http()
	
	set("title_id", PlayFabSettings.title_id)
	
	_store_fields_defaults()

func _notification(what: int) -> void:
	if what != NOTIFICATION_PREDELETE:
		return
	
	PlayFab.recycle_http(req_http)

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
	
	var sdk_header = "GDPlayFab-%s.%s" % [SDK_VERSION, req_api_version]
	var model_keys_pascal_case = true
	var model_only_dirty_props = true
	var data = ""
	
	if req_method == HTTPClient.METHOD_POST:
		data = JSON.stringify(_get_fields_as_dictionary(model_keys_pascal_case, model_only_dirty_props))
	
	var url = "https://%s.%s%s?sdk=%s" % [PlayFabSettings.title_id, req_api_url, req_path, sdk_header]
	var headers = req_extra_headers.duplicate(true)
	
	headers.append_array([
		"Content-Type: application/json",
		"Content-Length: %s" % data.length(),
		"X-PlayFabSDK: " + sdk_header
	])
	
	if req_authentication_type == AuthenticationType.ENTITY_TOKEN:
		headers.append("X-EntityToken: %s" % PlayFabSettings.get_entity_token())
	elif req_authentication_type == AuthenticationType.SESSION_TICKET:
		headers.append("X-Authorization: %s" % PlayFabSettings.get_session_token())
	elif req_authentication_type == AuthenticationType.DEVELOPER_SECRET_KEY:
		headers.append("X-SecretKey: %s" % PlayFabSettings.developer_secret_key)
	
	var attempt = req_http.request(url, PackedStringArray(headers), req_method, data)
	
	if not attempt == OK:
		return attempt
	
	_requesting = true
	reference()
	
	req_http.request_completed.connect(_on_request_completed, CONNECT_ONE_SHOT)
	
	return OK

# This only stores bool, int, float and String default values to prevent adding useless fields to the request.
func _store_fields_defaults() -> void:
	var defaults = {}
	
	for _field in req_fields:
		var value = get(_field)
		var value_type = typeof(value)
		
		if (
				value_type == TYPE_BOOL
				or value_type == TYPE_INT
				or value_type == TYPE_FLOAT
				or value_type == TYPE_STRING
			):
			
			defaults[_field] = value
	
	_defaults = defaults

func _check_required_fields() -> bool:
	for _field in req_required_fields:
		var value = get(_field)
		
		if (
				typeof(value) == TYPE_NIL
				|| (typeof(value) == TYPE_FLOAT and is_equal_approx(value, 0))
				|| (typeof(value) == TYPE_INT and value == 0)
				|| (typeof(value) == TYPE_STRING and value.is_empty())
				|| (typeof(value) == TYPE_DICTIONARY and value.is_empty())
				|| (typeof(value) == TYPE_ARRAY and value.is_empty())
			):
			
			if _field == "title_id":
				push_error("A title_id must be set on PlayFab.Settings for http requests to work.")
			
			return false
	
	return true

func _get_fields_as_dictionary(model_keys_pascal_case = false, model_only_dirty_props = false) -> Dictionary:
	var dict = {}
	
	for _field in req_fields:
		var value = get(_field)
		var value_type = typeof(value)
		var new_value
		
		if value is PlayFabModel:
			if _field in req_required_fields or value.is_dirty():
				new_value = value.to_dictionary(model_keys_pascal_case, model_only_dirty_props)
		elif value_type == TYPE_ARRAY:
			if _field in req_required_fields or not value.is_empty():
				new_value = PlayFabUtils.array_convert_models_to_dictionary(value, model_keys_pascal_case, model_only_dirty_props)
		elif value_type == TYPE_DICTIONARY:
			if _field in req_required_fields or not value.is_empty():
				new_value = PlayFabUtils.dictionary_convert_models_to_dictionary(value, model_keys_pascal_case, model_only_dirty_props)
		else:
			var default = _defaults.get(_field)
			
			if _field in req_required_fields or str(default) != str(value):
				new_value = value
		
		if model_keys_pascal_case:
			_field = _field.to_pascal_case()
		
		if new_value != null:
			dict[_field] = new_value
	
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
	
	if req_success_codes.has(code):
		_completed["expected"] = true
		
		var model = _new_result_model()
		
		if body_dict:
			model.parse_dictionary(body_dict.get("data", {}), dict_is_body_response)
		
		_completed["data"] = model
	elif req_error_codes.has(code):
		var error = PlayFabModel.ApiErrorWrapper.new()
		
		if body_dict:
			error.parse_dictionary(body_dict, dict_is_body_response)
		
		_completed["error"] = error
	
	completed.emit(result, code, headers, body)
	finished.emit(self)
	
	unreference.call_deferred()
