extends PlayFabHttpRequest
class_name PlayFabAuthentication

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
