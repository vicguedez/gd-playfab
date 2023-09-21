## Static class that holds shared settings for PlayFab sdks.
extends RefCounted
class_name PlayFabSettings

static var title_id: String
static var developer_secret_key: String
static var auto_idempotency_id: bool = false
static var auto_idempotency_id_bytes: int = 16
static var authentication_context = {
	"playfab_id": "",
	"entity_id": "",
	"entity_type": "",
	"entity_token": "",
	"session_token": ""
	}

static func set_authentication(result: PlayFabModel.AuthenticationResult) -> void:
	authentication_context.playfab_id = result.play_fab_id
	authentication_context.session_token = result.session_ticket
	
	set_entity_token(result.entity_token)

static func set_entity_token(response: PlayFabModel.EntityTokenResponse) -> void:
	authentication_context.entity_id = response.entity.id
	authentication_context.entity_type = response.entity.type
	authentication_context.entity_token = response.entity_token

static func clear_authentication() -> void:
	authentication_context.playfab_id = ""
	authentication_context.entity_id = ""
	authentication_context.entity_type = ""
	authentication_context.entity_token = ""
	authentication_context.session_token = ""

static func get_playfab_id() -> String:
	return authentication_context.playfab_id

static func get_entity_token() -> String:
	return authentication_context.entity_token

static func get_session_token() -> String:
	return authentication_context.session_token
