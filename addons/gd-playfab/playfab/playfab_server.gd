extends PlayFabHttpRequest
class_name PlayFabServer

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
	
	func get_response_data() -> PlayFabServerModel.GetPlayerCombinedInfoResultPayload:
		return super()
	
	func _new_result_model() -> PlayFabServerModel.GetPlayerCombinedInfoResultPayload:
		return PlayFabServerModel.GetPlayerCombinedInfoResultPayload.new()

