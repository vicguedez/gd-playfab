extends Node

var http_threads := true
var http_compress := false

var _http_pool: Array[HTTPRequest] = []

func _ready() -> void:
	pass

func get_http() -> HTTPRequest:
	var http = _http_pool.pop_front()
	
	if http == null:
		http = HTTPRequest.new()
		http.use_threads = http_threads
		http.accept_gzip = http_compress
		
		add_child(http)
	
	return http

func recycle_http(http: HTTPRequest) -> void:
	_http_pool.append(http)
