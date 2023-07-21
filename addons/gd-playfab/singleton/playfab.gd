extends Node

var Settings: PlayFabSettings
var Client: PlayFabClient

var _http_pool: Array[HTTPRequest] = []

func _ready() -> void:
	Settings = preload("res://addons/gd-playfab/playfab/playfab_settings.tscn").instantiate()
	Client = preload("res://addons/gd-playfab/playfab/playfab_client.tscn").instantiate()
	
	add_child(Settings)
	add_child(Client)

func get_http() -> HTTPRequest:
	var http = _http_pool.pop_front()
	
	if http == null:
		http = HTTPRequest.new()
		add_child(http)
	
	return http

func recycle_http(http: HTTPRequest) -> void:
	_http_pool.append(http)
