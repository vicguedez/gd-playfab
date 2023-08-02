extends PlayFabHttpRequest
class_name PlayFabEconomy
## SDK for PlayFab Economy.
## 
## Catalog Management APIs.[br]
## [br]
## In general for Catalog APIs, Read APIs are limited to 100 requests in 60 seconds for Player Entities while Title Entities are limited to 10000 requests in 10 seconds. For Write APIs, Player Entities are limited to 10 requests in 30 seconds and Title Entities are limited to 1000 requests in 10 seconds.[br]
## [br]
## Player Inventory Management APIs. [br]
## [br]
## Inventory operations work on an eventually consistent system against a cache of the Catalog. It can take a few moments for changes to propagate. In general for Inventory APIs, Read APIs are limited to 100 requests in 60 seconds for Player Entities while Title Entities are limited to 10000 requests in 10 seconds. For Write APIs, Player Entities are limited to 30 requests in 90 seconds and Title Entities are limited to 1000 requests in 10 seconds.[br]

## Retrieves items from the public catalog. Up to 50 items can be returned at once. GetItems does not work off a cache of the Catalog and should be used when trying to get recent item updates. However, please note that item references data is cached and may take a few moments for changes to propagate.
class GetItems extends PlayFabEconomy:
	## List of item alternate IDs.
	var alternate_ids: Array[PlayFabEconomyModel.CatalogAlternateId] = []
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## The entity to perform this action on.
	var entity: PlayFabEconomyModel.EntityKey = PlayFabEconomyModel.EntityKey.new()
	## List of Item Ids.
	var ids: Array[String]
	
	func _init() -> void:
		req_path = "/Catalog/GetItems"
		req_authentication_type = AuthenticationType.ENTITY_TOKEN
		req_fields = [
			"alternate_ids",
			"custom_tags",
			"entity",
			"ids",
			]
		
		super()
	
	func get_response_data() -> PlayFabEconomyModel.GetItemsResponse:
		return super()
	
	func _new_result_model() -> PlayFabEconomyModel.GetItemsResponse:
		return PlayFabEconomyModel.GetItemsResponse.new()

## Get current inventory items.
class GetIventoryItems extends PlayFabEconomy:
	## Number of items to retrieve. This value is optional. Maximum page size is 50. The default value is 10.
	var count: float
	## The id of the entity's collection to perform this action on. (Default="default").
	var collection_id: String
	## An opaque token used to retrieve the next page of items in the inventory, if any are available. Should be null on initial request.
	var continuation_token: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## The entity to perform this action on.
	var entity: PlayFabEconomyModel.EntityKey = PlayFabEconomyModel.EntityKey.new()
	## OData Filter to refine the items returned. InventoryItem properties 'type', 'id', and 'stackId' can be used in the filter. For example: "type eq 'currency'".
	var filter: String
	
	func _init() -> void:
		req_path = "/Inventory/GetInventoryItems"
		req_authentication_type = AuthenticationType.ENTITY_TOKEN
		req_fields = [
			"count",
			"collection_id",
			"continuation_token",
			"custom_tags",
			"entity",
			"filter",
			]
		req_required_fields = [
			"count",
			]
		
		super()
	
	func get_response_data() -> PlayFabEconomyModel.GetInventoryItemsResponse:
		return super()
	
	func _new_result_model() -> PlayFabEconomyModel.GetInventoryItemsResponse:
		return PlayFabEconomyModel.GetInventoryItemsResponse.new()
