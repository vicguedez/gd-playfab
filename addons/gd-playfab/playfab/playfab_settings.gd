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
