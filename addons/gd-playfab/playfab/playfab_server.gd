extends PlayFabHttpRequest
class_name PlayFabServer

## Validated a client's session ticket, and if successful, returns details for that user
class AuthenticateSessionTicket extends PlayFabServer:
	## Session ticket as issued by a PlayFab client login API.
	var session_ticket: String
	
	func _init() -> void:
		req_path = "/Server/AuthenticateSessionTicket"
		req_authentication_type = AuthenticationType.DEVELOPER_SECRET_KEY
		req_fields = [
			"session_ticket",
			]
		req_required_fields = [
			"session_ticket",
			]
		
		super()
	
	func get_response_data() -> PlayFabServerModel.AuthenticateSessionTicketResult:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.AuthenticateSessionTicketResult:
		return PlayFabServerModel.AuthenticateSessionTicketResult.new()

## Returns whatever info is requested in the response for the user. Note that PII (like email address, facebook id) may be returned. All parameters default to false.
class GetPlayerCombinedInfo extends PlayFabServer:
	## Flags for which pieces of info to return for the user.
	var info_request_parameters: PlayFabServerModel.GetPlayerCombinedInfoRequestParams = PlayFabServerModel.GetPlayerCombinedInfoRequestParams.new()
	## PlayFabId of the user whose data will be returned.
	var play_fab_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	
	func _init() -> void:
		req_path = "/Server/GetPlayerCombinedInfo"
		req_authentication_type = AuthenticationType.DEVELOPER_SECRET_KEY
		req_fields = [
			"info_request_parameters",
			"play_fab_id",
			"custom_tags",
			]
		req_required_fields = [
			"info_request_parameters",
			"play_fab_id",
			]
		
		super()
	
	func get_response_data() -> PlayFabServerModel.GetPlayerCombinedInfoResult:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.GetPlayerCombinedInfoResult:
		return PlayFabServerModel.GetPlayerCombinedInfoResult.new()

## Retrieves the title-specific custom data for the user which is readable and writable by the client
class GetUserData extends PlayFabServer:
	## Unique PlayFab assigned ID of the user on whom the operation will be performed.
	var play_fab_id: String
	## The version that currently exists according to the caller. The call will return the data for all of the keys if the version in the system is greater than this.
	var if_changed_from_data_version: float
	## Specific keys to search for in the custom user data.
	var keys: Array[String]
	
	func _init() -> void:
		req_path = "/Server/GetUserData"
		req_authentication_type = AuthenticationType.DEVELOPER_SECRET_KEY
		req_fields = [
			"play_fab_id",
			"if_changed_from_data_version",
			"keys",
			]
		req_required_fields = [
			"play_fab_id",
			]
		
		super()
	
	func get_response_data() -> PlayFabServerModel.GetUserDataResult:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.GetUserDataResult:
		return PlayFabServerModel.GetUserDataResult.new()

## Retrieves the title-specific custom data for the user which cannot be accessed by the client
class GetUserInternalData extends GetUserData:
	func _init() -> void:
		super()
		
		req_path = "/Server/GetUserInternalData"

## Retrieves the title-specific custom data for the user which can only be read by the client
class GetUserReadOnlyData extends GetUserData:
	func _init() -> void:
		super()
		
		req_path = "/Server/GetUserReadOnlyData"

## Updates the title-specific custom data for the user which is readable and writable by the client
class UpdateUserData extends PlayFabServer:
	## Unique PlayFab assigned ID of the user on whom the operation will be performed.
	var play_fab_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## Key-value pairs to be written to the custom data. Note that keys are trimmed of whitespace, are limited in size, and may not begin with a '!' character or be null.
	var data: Dictionary = {}
	## Optional list of Data-keys to remove from UserData. Some SDKs cannot insert null-values into Data due to language constraints. Use this to delete the keys directly.
	var keys_to_remove: Array[String]
	## Permission to be applied to all user data keys written in this request. Defaults to "private" if not set.
	var permission: String
	
	func _init() -> void:
		req_path = "/Server/UpdateUserData"
		req_authentication_type = AuthenticationType.DEVELOPER_SECRET_KEY
		req_fields = [
			"play_fab_id",
			"custom_tags",
			"data",
			"keys_to_remove",
			"permission",
			]
		req_required_fields = [
			"play_fab_id",
			]
		
		super()
	
	func get_response_data() -> PlayFabServerModel.UpdateUserDataResult:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.UpdateUserDataResult:
		return PlayFabServerModel.UpdateUserDataResult.new()

## Updates the title-specific custom data for the user which cannot be accessed by the client
class UpdateUserInternalData extends PlayFabServer:
	## Unique PlayFab assigned ID of the user on whom the operation will be performed.
	var play_fab_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## Key-value pairs to be written to the custom data. Note that keys are trimmed of whitespace, are limited in size, and may not begin with a '!' character or be null.
	var data: Dictionary = {}
	## Optional list of Data-keys to remove from UserData. Some SDKs cannot insert null-values into Data due to language constraints. Use this to delete the keys directly.
	var keys_to_remove: Array[String]
	
	func _init() -> void:
		req_path = "/Server/UpdateUserInternalData"
		req_authentication_type = AuthenticationType.DEVELOPER_SECRET_KEY
		req_fields = [
			"play_fab_id",
			"custom_tags",
			"data",
			"keys_to_remove",
			]
		req_required_fields = [
			"play_fab_id",
			]
		
		super()
	
	func get_response_data() -> PlayFabServerModel.UpdateUserDataResult:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.UpdateUserDataResult:
		return PlayFabServerModel.UpdateUserDataResult.new()

## Updates the title-specific custom data for the user which can only be read by the client
class UpdateUserReadOnlyData extends UpdateUserData:
	func _init() -> void:
		super()
		
		req_path = "/Server/UpdateUserReadOnlyData"
