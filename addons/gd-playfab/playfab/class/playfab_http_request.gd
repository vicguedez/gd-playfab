## Base class for all API calls. Should not be used directly.
extends RefCounted
class_name PlayFabHttpRequest

## Fired on request finished or object predelete notification. Used for the
## HTTPRequest pool managed by the PlayFab singleton.
signal http_released(http)

## Do not use unless you know what you are doing.
var http: HTTPRequest

## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
var custom_tags = {}

func _init() -> void:
	PlayFab.http_request_setup(self)

func _notification(what: int) -> void:
	if what != NOTIFICATION_PREDELETE or http == null:
		return
	
	http_released.emit(http)

func post(path: String, headers: Array[String], body: Dictionary):
	pass
