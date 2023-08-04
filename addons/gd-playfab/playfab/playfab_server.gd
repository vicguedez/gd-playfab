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
