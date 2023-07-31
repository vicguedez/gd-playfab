## Static class that holds shared settings for PlayFab sdks.
extends RefCounted
class_name PlayFabSettings

static var title_id: String

static var authentication_context = {
	"playfab_id": "",
	"entity_id": "",
	"entity_type": "",
	"entity_token": "",
	"session_token": ""
}

static func store_credentials_from_login_result(result: PlayFabModel.LoginResult) -> void:
	authentication_context.playfab_id = result.play_fab_id
	authentication_context.entity_id = result.entity_token.entity.id
	authentication_context.entity_type = result.entity_token.entity.type
	authentication_context.entity_token = result.entity_token.entity_token
	authentication_context.session_token = result.session_ticket
