extends PlayFabHttpRequest
class_name PlayFabAuthentication

## This API must be called with X-SecretKey, X-Authentication or X-EntityToken headers. An optional EntityKey may be included to attempt to set the resulting EntityToken to a specific entity, however the entity must be a relation of the caller, such as the master_player_account of a character. If sending X-EntityToken the account will be marked as freshly logged in and will issue a new token. If using X-Authentication or X-EntityToken the header must still be valid and cannot be expired or revoked.
class GetEntityToken extends PlayFabAuthentication:
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## The optional entity to perform this action on. Defaults to the currently logged in entity.
	var entity: PlayFabAuthenticationModel.EntityKey = PlayFabAuthenticationModel.EntityKey.new()
	
	func _init() -> void:
		super()
		
		req_path = "/Authentication/GetEntityToken"
		req_fields = [
			"custom_tags",
			"entity",
			]
	
	func get_response_data() -> PlayFabAuthenticationModel.EntityTokenResponse:
		return super()
	
	func _new_result_model() -> PlayFabAuthenticationModel.EntityTokenResponse:
		return PlayFabAuthenticationModel.EntityTokenResponse.new()

## Given an entity token, validates that it hasn't expired or been revoked and will return details of the owner.
class ValidateEntityToken extends PlayFabAuthentication:
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## Client EntityToken.
	var entity_token: String
	
	func _init() -> void:
		super()
		
		req_path = "/Authentication/ValidateEntityToken"
		req_fields = [
			"custom_tags",
			"entity_token",
			]
	
	func get_response_data() -> PlayFabAuthenticationModel.ValidateEntityTokenResponse:
		return super()
	
	func _new_result_model() -> PlayFabAuthenticationModel.ValidateEntityTokenResponse:
		return PlayFabAuthenticationModel.ValidateEntityTokenResponse.new()
