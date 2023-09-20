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

## Update inventory items
class UpdateInventoryItems extends PlayFabEconomy:
	## The id of the entity's collection to perform this action on. (Default="default"). The number of inventory collections is unlimited.
	var collection_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## ETags are used for concurrency checking when updating resources. More information about using ETags can be found here: https://learn.microsoft.com/en-us/gaming/playfab/features/economy-v2/catalog/etags.
	var e_tag: String
	## The entity to perform this action on.
	var entity: PlayFabEconomyModel.EntityKey = PlayFabEconomyModel.EntityKey.new()
	## The Idempotency ID for this request. Idempotency IDs can be used to prevent operation replay in the medium term but will be garbage collected eventually.
	var idempotency_id: String
	## The inventory item to update with the specified values.
	var item: PlayFabEconomyModel.InventoryItem = PlayFabEconomyModel.InventoryItem.new()
	
	func _init() -> void:
		req_path = "/Inventory/UpdateInventoryItems"
		req_authentication_type = AuthenticationType.ENTITY_TOKEN
		req_fields = [
			"collection_id",
			"custom_tags",
			"e_tag",
			"entity",
			"idempotency_id",
			"item",
			]
		
		super()
	
	func get_response_data() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return super()
	
	func _new_result_model() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return PlayFabEconomyModel.OperationInventoryItemsResponse.new()

## Add inventory items. Up to 3500 stacks of items can be added to a single inventory collection. Stack size is uncapped.
class AddInventoryItems extends PlayFabEconomy:
	## The amount to add for the current item.
	var amount: float
	## The id of the entity's collection to perform this action on. (Default="default"). The number of inventory collections is unlimited.
	var collection_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## The duration to add to the current item expiration date.
	var duration_in_seconds: float
	## ETags are used for concurrency checking when updating resources. More information about using ETags can be found here: https://learn.microsoft.com/en-us/gaming/playfab/features/economy-v2/catalog/etags.
	var e_tag: String
	## The entity to perform this action on.
	var entity: PlayFabEconomyModel.EntityKey = PlayFabEconomyModel.EntityKey.new()
	## The Idempotency ID for this request. Idempotency IDs can be used to prevent operation replay in the medium term but will be garbage collected eventually.
	var idempotency_id: String
	## The inventory item the request applies to.
	var item: PlayFabEconomyModel.InventoryItemReference = PlayFabEconomyModel.InventoryItemReference.new()
	## The values to apply to a stack newly created by this request.
	var new_stack_values: PlayFabEconomyModel.ItemInitialValues = PlayFabEconomyModel.ItemInitialValues.new()
	
	func _init() -> void:
		req_path = "/Inventory/AddInventoryItems"
		req_authentication_type = AuthenticationType.ENTITY_TOKEN
		req_fields = [
			"amount",
			"collection_id",
			"custom_tags",
			"duration_in_seconds",
			"e_tag",
			"entity",
			"idempotency_id",
			"item",
			"new_stack_values",
			]
		
		super()
	
	func get_response_data() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return super()
	
	func _new_result_model() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return PlayFabEconomyModel.OperationInventoryItemsResponse.new()

## Subtract inventory items.
class SubtractInventoryItems extends PlayFabEconomy:
	## Indicates whether stacks reduced to an amount of 0 during the request should be deleted from the inventory. (Default=false).
	var delete_empty_stacks: bool
	## The amount to subtract for the current item.
	var amount: float
	## The id of the entity's collection to perform this action on. (Default="default"). The number of inventory collections is unlimited.
	var collection_id: String
	## The optional custom tags associated with the request (e.g. build number, external trace identifiers, etc.).
	var custom_tags: Dictionary = {}
	## The duration to subtract from the current item expiration date.
	var duration_in_seconds: float
	## ETags are used for concurrency checking when updating resources. More information about using ETags can be found here: https://learn.microsoft.com/en-us/gaming/playfab/features/economy-v2/catalog/etags.
	var e_tag: String
	## The entity to perform this action on.
	var entity: PlayFabEconomyModel.EntityKey = PlayFabEconomyModel.EntityKey.new()
	## The Idempotency ID for this request. Idempotency IDs can be used to prevent operation replay in the medium term but will be garbage collected eventually.
	var idempotency_id: String
	## The inventory item the request applies to.
	var item: PlayFabEconomyModel.InventoryItemReference = PlayFabEconomyModel.InventoryItemReference.new()
	
	func _init() -> void:
		req_path = "/Inventory/SubtractInventoryItems"
		req_authentication_type = AuthenticationType.ENTITY_TOKEN
		req_fields = [
			"delete_empty_stacks",
			"amount",
			"collection_id",
			"custom_tags",
			"duration_in_seconds",
			"e_tag",
			"entity",
			"idempotency_id",
			"item",
			]
		req_required_fields = [
			"delete_empty_stacks",
			]
		
		super()
	
	func get_response_data() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return super()
	
	func _new_result_model() -> PlayFabEconomyModel.OperationInventoryItemsResponse:
		return PlayFabEconomyModel.OperationInventoryItemsResponse.new()
