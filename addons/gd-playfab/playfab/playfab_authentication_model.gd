extends PlayFabModel
class_name PlayFabAuthenticationModel

class ValidateEntityTokenResponse extends PlayFabAuthenticationModel:
	## The entity id and type.
	var entity: EntityKey
	## The authenticated device for this entity, for the given login.
	var identified_device_type: String
	## The identity provider for this entity, for the given login.
	var identity_provider: String
	## The ID issued by the identity provider, e.g. a XUID on Xbox Live.
	var identity_provider_issued_id: String
	## The lineage of this profile.
	var lineage: EntityLineage
	
	func _property_get_revert(property: StringName) -> Variant:
		if property == &"entity":
			return EntityKey.new()
		elif property == &"lineage":
			return EntityLineage.new()
		
		return null

