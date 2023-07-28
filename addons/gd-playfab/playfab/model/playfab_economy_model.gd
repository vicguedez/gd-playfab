extends PlayFabModel
class_name PlayFabEconomyModel

class CatalogAlternateId extends PlayFabEconomyModel:
	## Type of the alternate ID.
	var type: String
	## Value of the alternate ID.
	var value: String

class Content extends PlayFabEconomyModel:
	## The content unique ID.
	var id: String
	## The maximum client version that this content is compatible with. Client Versions can be up to 3 segments separated by periods(.) and each segment can have a maximum value of 65535.
	var max_client_version: String
	## The minimum client version that this content is compatible with. Client Versions can be up to 3 segments separated by periods(.) and each segment can have a maximum value of 65535.
	var min_client_version: String
	## The list of tags that are associated with this content. Tags must be defined in the Catalog Config before being used in content.
	var tags: Array[String]
	## The client-defined type of the content. Content Types must be defined in the Catalog Config before being used.
	var type: String
	## The Azure CDN URL for retrieval of the catalog item binary content.
	var url: String

class DeepLink extends PlayFabEconomyModel:
	## Target platform for this deep link.
	var platform: String
	## The deep link for this platform.
	var url: String

## Prefixed with PF to fix collision with Godot's Image class.
class PFImage extends PlayFabEconomyModel:
	## The image unique ID.
	var id: String
	## The client-defined tag associated with this image. Tags must be defined in the Catalog Config before being used in images.
	var tag: String
	## Images can be defined as either a "thumbnail" or "screenshot". There can only be one "thumbnail" image per item.
	var type: String
	## The URL for retrieval of the image.
	var url: String

class CatalogPriceAmount extends PlayFabEconomyModel:
	## The amount of the price.
	var amount: float
	## The Item Id of the price.
	var item_id: String

class CatalogPrice extends PlayFabEconomyModel:
	## The amounts of the catalog item price. Each price can have up to 15 item amounts.
	var amounts: Array[CatalogPriceAmount]
	## The per-unit amount this price can be used to purchase.
	var unit_amount: float
	## The per-unit duration this price can be used to purchase. The maximum duration is 100 years.
	var unit_duration_in_seconds: float

class CatalogPriceOptions extends PlayFabEconomyModel:
	## Prices of the catalog item. An item can have up to 15 prices.
	var prices: Array[CatalogPrice]

class CatalogItemReference extends PlayFabEconomyModel:
	## The amount of the catalog item.
	var amount: float
	## The unique ID of the catalog item.
	var id: String
	## The prices the catalog item can be purchased for.
	var price_options: CatalogPriceOptions
	
	func _property_get_revert(property: StringName) -> Variant:
		if property == &"price_options":
			return CatalogPriceOptions.new()
		
		return null

class KeywordSet extends PlayFabEconomyModel:
	## A list of localized keywords.
	var values: Array[String]

class ModerationState extends PlayFabEconomyModel:
	## The date and time this moderation state was last updated.
	var last_modified_date: String
	## The current stated reason for the associated item being moderated.
	var reason: String
	## The current moderation status for the associated item.
	var status: String

class Rating extends PlayFabEconomyModel:
	## The average rating for this item.
	var average: float
	## The total count of 1 star ratings for this item.
	var count_1_star: float
	## The total count of 2 star ratings for this item.
	var count_2_star: float
	## The total count of 3 star ratings for this item.
	var count_3_star: float
	## The total count of 4 star ratings for this item.
	var count_4_star: float
	## The total count of 5 star ratings for this item.
	var count_5_star: float
	## The total count of ratings for this item.
	var total_count: float

class FilterOptions extends PlayFabEconomyModel:
	## The OData filter utilized. Mutually exclusive with 'IncludeAllItems'. More info about Filter Complexity limits can be found here: https://learn.microsoft.com/en-us/gaming/playfab/features/economy-v2/catalog/search#limits.
	var filter: String
	## The flag that overrides the filter and allows for returning all catalog items. Mutually exclusive with 'Filter'.
	var include_all_items: bool

class CatalogPriceAmountOverride extends PlayFabEconomyModel:
	## The exact value that should be utilized in the override.
	var fixed_value: float
	## The id of the item this override should utilize.
	var item_id: String
	## The multiplier that will be applied to the base Catalog value to determine what value should be utilized in the override.
	var multiplier: float

class CatalogPriceOverride extends PlayFabEconomyModel:
	## The currency amounts utilized in the override for a singular price.
	var amounts: Array[CatalogPriceAmountOverride]

class CatalogPriceOptionsOverride extends PlayFabEconomyModel:
	## The prices utilized in the override.
	var prices: Array[CatalogPriceOverride]

class StoreDetails extends PlayFabEconomyModel:
	## The options for the filter in filter-based stores. These options are mutually exclusive with item references.
	var filter_options: FilterOptions
	## The global prices utilized in the store. These options are mutually exclusive with price options in item references.
	var price_options_override: CatalogPriceOptionsOverride
	
	func _property_get_revert(property: StringName) -> Variant:
		if property == &"filter_options":
			return FilterOptions.new()
		elif property == &"price_options_override":
			return CatalogPriceOptionsOverride.new()
		
		return null

class CatalogItem extends PlayFabEconomyModel:
	## The alternate IDs associated with this item. An alternate ID can be set to 'FriendlyId' or any of the supported marketplace names.
	var alternate_ids: Array[CatalogAlternateId]
	## The client-defined type of the item.
	var content_type: String
	## The set of content/files associated with this item. Up to 100 files can be added to an item.
	var contents: Array[Content]
	## The date and time when this item was created.
	var creation_date: String
	## The ID of the creator of this catalog item.
	var creator_entity: EntityKey
	## The set of platform specific deep links for this item.
	var deep_links: Array[DeepLink]
	## The Stack Id that will be used as default for this item in Inventory when an explicit one is not provided. This DefaultStackId can be a static stack id or '{guid}', which will generate a unique stack id for the item. If null, Inventory's default stack id will be used.
	var default_stack_id: String
	## A dictionary of localized descriptions. Key is language code and localized string is the value. The NEUTRAL locale is required. Descriptions have a 10000 character limit per country code.
	var description: Dictionary
	## Game specific properties for display purposes. This is an arbitrary JSON blob. The Display Properties field has a 10000 byte limit per item.
	var display_properties: Dictionary
	## The user provided version of the item for display purposes. Maximum character length of 50.
	var display_version: String
	## The current ETag value that can be used for optimistic concurrency in the If-None-Match header.
	var e_tag: String
	## The date of when the item will cease to be available. If not provided then the product will be available indefinitely.
	var end_date: String
	## The unique ID of the item.
	var id: String
	## The images associated with this item. Images can be thumbnails or screenshots. Up to 100 images can be added to an item. Only .png, .jpg, .gif, and .bmp file types can be uploaded.
	var images: Array[Image]
	## Indicates if the item is hidden.
	var is_hidden: bool
	## The item references associated with this item. For example, the items in a Bundle/Store/Subscription. Every item can have up to 50 item references.
	var item_references: Array[CatalogItemReference]
	## A dictionary of localized keywords. Key is language code and localized list of keywords is the value. Keywords have a 50 character limit per keyword and up to 32 keywords can be added per country code.
	var keywords: KeywordSet
	## The date and time this item was last updated.
	var last_modified_date: String
	## The moderation state for this item.
	var moderation: ModerationState
	## The platforms supported by this item.
	var platforms: Array[String]
	## The prices the item can be purchased for.
	var price_options: CatalogPriceOptions
	## Rating summary for this item.
	var rating: Rating
	## The date of when the item will be available. If not provided then the product will appear immediately.
	var start_date: String
	## Optional details for stores items.
	var store_details: StoreDetails
	## The list of tags that are associated with this item. Up to 32 tags can be added to an item.
	var tags: Array[String]
	## A dictionary of localized titles. Key is language code and localized string is the value. The NEUTRAL locale is required. Titles have a 512 character limit per country code.
	var title: Dictionary
	## The high-level type of the item. The following item types are supported: bundle, catalogItem, currency, store, ugc, subscription.
	var type: String
	
	func _property_get_revert(property: StringName) -> Variant:
		if property == &"creator_entity":
			return EntityKey.new()
		elif property == &"keywords":
			return KeywordSet.new()
		elif property == &"moderation":
			return ModerationState.new()
		elif property == &"price_options":
			return CatalogPriceOptions.new()
		elif property == &"rating":
			return Rating.new()
		elif property == &"store_details":
			return StoreDetails.new()
		
		return null

class GetItemsResponse extends PlayFabEconomyModel:
	## Metadata of set of items.
	var items: Array[CatalogItem]

class InventoryItem extends PlayFabEconomyModel:
	## The amount of the item.
	var amount: float
	## Game specific properties for display purposes. This is an arbitrary JSON blob. The Display Properties field has a 1000 byte limit.
	var display_properties: Dictionary
	## Only used for subscriptions. The date of when the item will expire in UTC.
	var expiration_date: String
	## The id of the item. This should correspond to the item id in the catalog.
	var id: String
	## The stack id of the item.
	var stack_id: String
	## The type of the item. This should correspond to the item type in the catalog.
	var type: String

class GetInventoryItemsResponse extends PlayFabEconomyModel:
	## An opaque token used to retrieve the next page of items, if any are available.
	var continuation_token: String
	## ETags are used for concurrency checking when updating resources. More information about using ETags can be found here: https://learn.microsoft.com/en-us/gaming/playfab/features/economy-v2/catalog/etags.
	var e_tag: String
	## The requested inventory items.
	var items: Array[InventoryItem]

