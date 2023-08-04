extends PlayFabModel
class_name PlayFabServerModel

class AuthenticateSessionTicketResult extends PlayFabServerModel:
	## Indicates if token was expired at request time.
	var is_session_ticket_expired: bool
	## Account info for the user whose session ticket was supplied.
	var user_info: UserAccountInfo
	
	func _property_get_revert(property: StringName) -> Variant:
		if property == &"user_info":
			return UserAccountInfo.new()
		
		return null

