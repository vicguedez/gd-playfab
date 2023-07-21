@tool
extends EditorPlugin

const SINGLETON_NAME := "PlayFab"
const SINGLETON_PATH := "res://addons/gd-playfab/singleton/playfab.tscn"

const MODEL_PARSER = preload("res://addons/gd-playfab/tool/model_parser.tscn")

var model_parser: Control

func _enter_tree() -> void:
	model_parser = MODEL_PARSER.instantiate()
	
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	add_control_to_bottom_panel(model_parser, "PlayFab Model Parser")

func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
	remove_control_from_bottom_panel(model_parser)
	
	model_parser.queue_free()
