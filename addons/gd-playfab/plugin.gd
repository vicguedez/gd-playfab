@tool
extends EditorPlugin

const SINGLETON_NAME := "PlayFab"
const SINGLETON_PATH := "res://addons/gd-playfab/singleton/playfab.tscn"

const MODEL_PARSER = preload("res://addons/gd-playfab/tool/api_parser.tscn")

var api_parser: Control

func _enter_tree() -> void:
	api_parser = MODEL_PARSER.instantiate()
	
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	add_control_to_bottom_panel(api_parser, "PlayFab API Parser")

func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
	remove_control_from_bottom_panel(api_parser)
	
	api_parser.queue_free()
