extends Node

var Settings: PlayFabSettings
var Client: PlayFabClient

const _http_pool: Array[HTTPRequest] = []

func _ready() -> void:
	Settings = preload("res://addons/gd-playfab/playfab/playfab_settings.tscn").instantiate()
	Client = preload("res://addons/gd-playfab/playfab/playfab_client.tscn").instantiate()
	
	add_child(Settings)
	add_child(Client)

func http_request_setup(request: PlayFabHttpRequest) -> void:
	request.http = _http_pool.pop_front()
	
	if request.http == null:
		request.http = HTTPRequest.new()
		add_child(request.http)
	
	request.http_released.connect(_on_request_http_released)

func _on_request_http_released(http: HTTPRequest) -> void:
	_http_pool.append(http)
