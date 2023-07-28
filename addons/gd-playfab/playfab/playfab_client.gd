## SDK for PlayFab client management and services.
extends RefCounted
class_name PlayFabClient

## Signs the user into the PlayFab account, returning a session identifier that can subsequently be used for API calls which require an authenticated user. Unlike most other login API calls, LoginWithEmailAddress does not permit the creation of new accounts via the CreateAccountFlag. Email addresses may be used to create accounts via RegisterPlayFabUser.
class LoginWithEmailAddress extends PlayFabHttpRequest:
	## Email address for the account.
	var email: String
	## Password for the PlayFab account (6-100 characters).
	var password: String
	## Unique identifier for the title, found in the Settings > Game Properties section of the PlayFab developer site when a title has been selected.
	var title_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## Flags for which pieces of info to return for the user.
	var info_request_parameters: PlayFabModel.GetPlayerCombinedInfoRequestParams = PlayFabModel.GetPlayerCombinedInfoRequestParams.new()
	
	func get_config() -> Dictionary:
		return {
			"path": "/Client/LoginWithEmailAddress",
			"fields": {
				"email": email,
				"password": password,
				"title_id": title_id,
				"custom_tags": custom_tags,
				"info_request_parameters": info_request_parameters,
			},
			"required_fields": ["email","password","title_id"],
		}
	
	func get_response_data() -> PlayFabModel.LoginResult:
		return super()
	
	func _new_result_model() -> PlayFabModel.LoginResult:
		return PlayFabModel.LoginResult.new()
