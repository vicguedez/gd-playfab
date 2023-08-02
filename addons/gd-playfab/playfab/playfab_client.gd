## SDK for PlayFab client management and services.
extends PlayFabHttpRequest
class_name PlayFabClient

## Signs the user into the PlayFab account, returning a session identifier that can subsequently be used for API calls which require an authenticated user. Unlike most other login API calls, LoginWithEmailAddress does not permit the creation of new accounts via the CreateAccountFlag. Email addresses may be used to create accounts via RegisterPlayFabUser.
class LoginWithEmailAddress extends PlayFabClient:
	## Email address for the account.
	var email: String
	## Password for the PlayFab account (6-100 characters).
	var password: String
	## Unique identifier for the title, found in the Settings > Game Properties section of the PlayFab developer site when a title has been selected.
	var title_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## Flags for which pieces of info to return for the user.
	var info_request_parameters: PlayFabClientModel.GetPlayerCombinedInfoRequestParams = PlayFabClientModel.GetPlayerCombinedInfoRequestParams.new()
	
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
	
	func get_response_data() -> PlayFabClientModel.LoginResult:
		return super()
	
	func _new_result_model() -> PlayFabClientModel.LoginResult:
		return PlayFabClientModel.LoginResult.new()

class RegisterPlayFabUser extends PlayFabClient:
	## Unique identifier for the title, found in the Settings > Game Properties section of the PlayFab developer site when a title has been selected.
	var title_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## An optional parameter for setting the display name for this title (3-25 characters).
	var display_name: String
	## User email address attached to their account.
	var email: String
	## Base64 encoded body that is encrypted with the Title's public RSA key (Enterprise Only).
	var encrypted_request: String
	## Flags for which pieces of info to return for the user.
	var info_request_parameters: PlayFabClientModel.GetPlayerCombinedInfoRequestParams = PlayFabClientModel.GetPlayerCombinedInfoRequestParams.new()
	## Password for the PlayFab account (6-100 characters).
	var password: String
	## Player secret that is used to verify API request signatures (Enterprise Only).
	var player_secret: String
	## An optional parameter that specifies whether both the username and email parameters are required. If true, both parameters are required; if false, the user must supply either the username or email parameter. The default value is true.
	var require_both_username_and_email: bool = true
	## PlayFab username for the account (3-20 characters).
	var username: String
	
	func get_config() -> Dictionary:
		return {
			"path": "/Client/RegisterPlayFabUser",
			"fields": {
				"title_id": title_id,
				"custom_tags": custom_tags,
				"display_name": display_name,
				"email": email,
				"encrypted_request": encrypted_request,
				"info_request_parameters": info_request_parameters,
				"password": password,
				"player_secret": player_secret,
				"require_both_username_and_email": require_both_username_and_email,
				"username": username,
			},
			"required_fields": ["title_id"],
		}
	
	func get_response_data() -> PlayFabClientModel.RegisterPlayFabUserResult:
		return super()
	
	func _new_result_model() -> PlayFabClientModel.RegisterPlayFabUserResult:
		return PlayFabClientModel.RegisterPlayFabUserResult.new()

