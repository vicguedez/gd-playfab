extends RefCounted
class_name PlayFabModel

## Returns the whole model as a Dictionary, any model within it will be converted as well.
func to_dictionary() -> Dictionary:
	var dict = {}
	var prop_list = get_property_list()
	
	for prop in prop_list:
		if prop.usage != PROPERTY_USAGE_SCRIPT_VARIABLE:
			continue
		
		var value = get(prop.name)
		var new_value = value
		
		if value is PlayFabModel:
			new_value = value.to_dictionary()
		elif prop.type == TYPE_ARRAY:
			new_value = PlayFabUtils.array_convert_models_to_dictionary(value)
		elif prop.type == TYPE_DICTIONARY:
			new_value = PlayFabUtils.dictionary_convert_models_to_dictionary(value)
		
		dict[prop.name] = new_value
	
	return dict

## Combined entity type and ID structure which uniquely identifies a single entity.
class EntityKey extends PlayFabModel:
	## Unique ID of the entity.
	var id: String
	## Entity type. See https://docs.microsoft.com/gaming/playfab/features/data/entities/available-built-in-entity-types.
	var type: String

class EntityTokenResponse extends PlayFabModel:
	## The entity id and type.
	var entity: EntityKey
	## The token used to set X-EntityToken for all entity based API calls.
	var entity_token: String
	## The time the token will expire, if it is an expiring token, in UTC.
	var token_expiration: String

class UserPrivateAccountInfo extends PlayFabModel:
	## user email address
	var email: String

class UserTitleInfo extends PlayFabModel:
	## URL to the player's avatar.
	var avatar_url: String
	## timestamp indicating when the user was first associated with this game (this can differ significantly from when the user first registered with PlayFab).
	var created: String
	## name of the user, as it is displayed in-game.
	var display_name: String
	## timestamp indicating when the user first signed into this game (this can differ from the Created timestamp, as other events, such as issuing a beta key to the user, can associate the title to the user).
	var first_login: String
	## timestamp for the last user login for this title.
	var last_login: String
	## source by which the user first joined the game, if known.
	var origination: String
	## Title player account entity for this user.
	var title_player_account: EntityKey
	## boolean indicating whether or not the user is currently banned for a title.
	var is_banned: bool

class UserAndroidDeviceInfo extends PlayFabModel:
	## Android device ID.
	var android_device_id: String

class UserAppleIdInfo extends PlayFabModel:
	## Apple subject ID.
	var apple_subject_id: String

class UserCustomIdInfo extends PlayFabModel:
	## Custom ID.
	var custom_id: String

class UserFacebookInfo extends PlayFabModel:
	## Facebook identifier.
	var facebook_id: String
	## Facebook full name.
	var full_name: String

class UserFacebookInstantGamesIdInfo extends PlayFabModel:
	## Facebook Instant Games ID.
	var facebook_instant_games_id: String

class UserGameCenterInfo extends PlayFabModel:
	## Gamecenter identifier.
	var game_center_id: String

class UserGoogleInfo extends PlayFabModel:
	## Email address of the Google account.
	var google_email: String
	## Gender information of the Google account.
	var google_gender: String
	## Google ID.
	var google_id: String
	## Locale of the Google account.
	var google_locale: String
	## Name of the Google account user.
	var google_name: String

class UserGooglePlayGamesInfo extends PlayFabModel:
	## Avatar image url of the Google Play Games player.
	var google_play_games_player_avatar_image_url: String
	## Display name of the Google Play Games player.
	var google_play_games_player_display_name: String
	## Google Play Games player ID.
	var google_play_games_player_id: String

class UserIosDeviceInfo extends PlayFabModel:
	## iOS device ID.
	var ios_device_id: String

class UserKongregateInfo extends PlayFabModel:
	## Kongregate ID.
	var kongregate_id: String
	## Kongregate Username.
	var kongregate_name: String

class UserNintendoSwitchAccountIdInfo extends PlayFabModel:
	## Nintendo Switch account subject ID.
	var nintendo_switch_account_subject_id: String

class UserNintendoSwitchDeviceIdInfo extends PlayFabModel:
	## Nintendo Switch Device ID.
	var nintendo_switch_device_id: String

class UserOpenIdInfo extends PlayFabModel:
	## OpenID Connection ID.
	var connection_id: String
	## OpenID Issuer.
	var issuer: String
	## OpenID Subject.
	var subject: String

class UserPsnInfo extends PlayFabModel:
	## PlayStation ™️ Network account ID.
	var psn_account_id: String
	## PlayStation ™️ Network online ID.
	var psn_online_id: String

class TitleActivationStatus extends PlayFabModel:
	var activated_steam: String
	var activated_title_key: String
	var none: String
	var pending_steam: String
	var revoked_steam: String

class UserSteamInfo extends PlayFabModel:
	## what stage of game ownership the user is listed as being in, from Steam.
	var steam_activation_status: TitleActivationStatus
	## the country in which the player resides, from Steam data.
	var steam_country: String
	## currency type set in the user Steam account.
	var steam_currency: String
	## Steam identifier.
	var steam_id: String
	## Steam display name.
	var steam_name: String

class UserTwitchInfo extends PlayFabModel:
	## Twitch ID.
	var twitch_id: String
	## Twitch Username.
	var twitch_user_name: String

class UserXboxInfo extends PlayFabModel:
	## XBox user ID.
	var xbox_user_id: String
	## XBox user sandbox.
	var xbox_user_sandbox: String

class UserAccountInfo extends PlayFabModel:
	## User Android device information, if an Android device has been linked.
	var android_device_info: UserAndroidDeviceInfo
	## Sign in with Apple account information, if an Apple account has been linked.
	var apple_account_info: UserAppleIdInfo
	## Timestamp indicating when the user account was created.
	var created: String
	## Custom ID information, if a custom ID has been assigned.
	var custom_id_info: UserCustomIdInfo
	## User Facebook information, if a Facebook account has been linked.
	var facebook_info: UserFacebookInfo
	## Facebook Instant Games account information, if a Facebook Instant Games account has been linked.
	var facebook_instant_games_id_info: UserFacebookInstantGamesIdInfo
	## User Gamecenter information, if a Gamecenter account has been linked.
	var game_center_info: UserGameCenterInfo
	## User Google account information, if a Google account has been linked.
	var google_info: UserGoogleInfo
	## User Google Play Games account information, if a Google Play Games account has been linked.
	var google_play_games_info: UserGooglePlayGamesInfo
	## User iOS device information, if an iOS device has been linked.
	var ios_device_info: UserIosDeviceInfo
	## User Kongregate account information, if a Kongregate account has been linked.
	var kongregate_info: UserKongregateInfo
	## Nintendo Switch account information, if a Nintendo Switch account has been linked.
	var nintendo_switch_account_info: UserNintendoSwitchAccountIdInfo
	## Nintendo Switch device information, if a Nintendo Switch device has been linked.
	var nintendo_switch_device_id_info: UserNintendoSwitchDeviceIdInfo
	## OpenID Connect information, if any OpenID Connect accounts have been linked.
	var open_id_info: Array[UserOpenIdInfo]
	## Unique identifier for the user account.
	var play_fab_id: String
	## Personal information for the user which is considered more sensitive.
	var private_info: UserPrivateAccountInfo
	## User PlayStation ™️ Network account information, if a PlayStation ™️ Network account has been linked.
	var psn_info: UserPsnInfo
	## User Steam information, if a Steam account has been linked.
	var steam_info: UserSteamInfo
	## Title-specific information for the user account.
	var title_info: UserTitleInfo
	## User Twitch account information, if a Twitch account has been linked.
	var twitch_info: UserTwitchInfo
	## User account name in the PlayFab service.
	var username: String
	## User XBox account information, if a XBox account has been linked.
	var xbox_info: UserXboxInfo

## A unique instance of an item in a user's inventory. Note, to retrieve additional information for an item such as Tags, Description that are the same across all instances of the item, a call to GetCatalogItems is required. The ItemID of can be matched to a catalog entry, which contains the additional information. Also note that Custom Data is only set when the User's specific instance has updated the CustomData via a call to UpdateUserInventoryItemCustomData. Other fields such as UnitPrice and UnitCurrency are only set when the item was granted via a purchase.
class ItemInstance extends PlayFabModel:
	## Game specific comment associated with this instance when it was added to the user inventory.
	var annotation: String
	## Array of unique items that were awarded when this catalog item was purchased.
	var bundle_contents: Array[String]
	## Unique identifier for the parent inventory item, as defined in the catalog, for object which were added from a bundle or container.
	var bundle_parent: String
	## Catalog version for the inventory item, when this instance was created.
	var catalog_version: String
	## A set of custom key-value pairs on the instance of the inventory item, which is not to be confused with the catalog item's custom data.
	var custom_data: Dictionary
	## CatalogItem.DisplayName at the time this item was purchased.
	var display_name: String
	## Timestamp for when this instance will expire.
	var expiration: String
	## Class name for the inventory item, as defined in the catalog.
	var item_class: String
	## Unique identifier for the inventory item, as defined in the catalog.
	var item_id: String
	## Unique item identifier for this specific instance of the item.
	var item_instance_id: String
	## Timestamp for when this instance was purchased.
	var purchase_date: String
	## Total number of remaining uses, if this is a consumable item.
	var remaining_uses: float
	## Currency type for the cost of the catalog item. Not available when granting items.
	var unit_currency: String
	## Cost of the catalog item in the given currency. Not available when granting items.
	var unit_price: float
	## The number of uses that were added or removed to this item in this call.
	var uses_incremented_by: float

class CharacterInventory extends PlayFabModel:
	## The id of this character.
	var character_id: String
	## The inventory of this character.
	var inventory: Array[ItemInstance]

class CharacterResult extends PlayFabModel:
	## The id for this character on this player.
	var character_id: String
	## The name of this character.
	var character_name: String
	## The type-string that was given to this character on creation.
	var character_type: String

class AdCampaignAttributionModel extends PlayFabModel:
	## UTC time stamp of attribution.
	var attributed_at: String
	## Attribution campaign identifier.
	var campaign_id: String
	## Attribution network name.
	var platform: String

class EmailVerificationStatus extends PlayFabModel:
	var confirmed: String
	var pending: String
	var unverified: String

class ContactEmailInfoModel extends PlayFabModel:
	## The email address.
	var email_address: String
	## The name of the email info data.
	var name: String
	## The verification status of the email.
	var verification_status: EmailVerificationStatus

class LinkedPlatformAccountModel extends PlayFabModel:
	## Linked account email of the user on the platform, if available.
	var email: String
	## Authentication platform.
	var platform: String
	## Unique account identifier of the user on the platform.
	var platform_user_id: String
	## Linked account username of the user on the platform, if available.
	var username: String

class LocationModel extends PlayFabModel:
	## City name.
	var city: String
	## The two-character continent code for this location.
	var continent_code: String
	## The two-character ISO 3166-1 country code for the country associated with the location.
	var country_code: String
	## Latitude coordinate of the geographic location.
	var latitude: float
	## Longitude coordinate of the geographic location.
	var longitude: float

class SubscriptionProviderStatus extends PlayFabModel:
	var billing_error: String
	var cancelled: String
	var customer_did_not_accept_price_change: String
	var free_trial: String
	var no_error: String
	var payment_pending: String
	var product_unavailable: String
	var unknown_error: String

class SubscriptionModel extends PlayFabModel:
	## When this subscription expires.
	var expiration: String
	## The time the subscription was orignially purchased.
	var initial_subscription_time: String
	## Whether this subscription is currently active. That is, if Expiration > now.
	var is_active: bool
	## The status of this subscription, according to the subscription provider.
	var status: SubscriptionProviderStatus
	## The id for this subscription.
	var subscription_id: String
	## The item id for this subscription from the primary catalog.
	var subscription_item_id: String
	## The provider for this subscription. Apple or Google Play are supported today.
	var subscription_provider: String

class MembershipModel extends PlayFabModel:
	## Whether this membership is active. That is, whether the MembershipExpiration time has been reached.
	var is_active: bool
	## The time this membership expires.
	var membership_expiration: String
	## The id of the membership.
	var membership_id: String
	## Membership expirations can be explicitly overridden (via game manager or the admin api). If this membership has been overridden, this will be the new expiration time.
	var override_expiration: String
	## Whether the override expiration is set.
	var override_is_set: bool
	## The list of subscriptions that this player has for this membership.
	var subscriptions: Array[SubscriptionModel]

class PushNotificationPlatform extends PlayFabModel:
	var apple_push_notification_service: String
	var google_cloud_messaging: String

class PushNotificationRegistrationModel extends PlayFabModel:
	## Notification configured endpoint.
	var notification_endpoint_arn: String
	## Push notification platform.
	var platform: PushNotificationPlatform

class StatisticModel extends PlayFabModel:
	## Statistic name.
	var name: String
	## Statistic value.
	var value: float
	## Statistic version (0 if not a versioned statistic).
	var version: float

class TagModel extends PlayFabModel:
	## Full value of the tag, including namespace.
	var tag_value: String

class ValueToDateModel extends PlayFabModel:
	## ISO 4217 code of the currency used in the purchases.
	var currency: String
	## Total value of the purchases in a whole number of 1/100 monetary units. For example, 999 indicates nine dollars and ninety-nine cents when Currency is 'USD').
	var total_value: float
	## Total value of the purchases in a string representation of decimal monetary units. For example, '9.99' indicates nine dollars and ninety-nine cents when Currency is 'USD'.
	var total_value_as_decimal: String

class PlayerProfileModel extends PlayFabModel:
	## List of advertising campaigns the player has been attributed to.
	var ad_campaign_attributions: Array[AdCampaignAttributionModel]
	## URL of the player's avatar image.
	var avatar_url: String
	## If the player is currently banned, the UTC Date when the ban expires.
	var banned_until: String
	## List of all contact email info associated with the player account.
	var contact_email_addresses: Array[ContactEmailInfoModel]
	## Player record created.
	var created: String
	## Player display name.
	var display_name: String
	## List of experiment variants for the player. Note that these variants are not guaranteed to be up-to-date when returned during login because the player profile is updated only after login. Instead, use the LoginResult.TreatmentAssignment property during login to get the correct variants and variables.
	var experiment_variants: Array[String]
	## UTC time when the player most recently logged in to the title.
	var last_login: String
	## List of all authentication systems linked to this player account.
	var linked_accounts: Array[LinkedPlatformAccountModel]
	## List of geographic locations from which the player has logged in to the title.
	var locations: Array[LocationModel]
	## List of memberships for the player, along with whether are expired.
	var memberships: Array[MembershipModel]
	## Player account origination.
	var origination: String
	## PlayFab player account unique identifier.
	var player_id: String
	## Publisher this player belongs to.
	var publisher_id: String
	## List of configured end points registered for sending the player push notifications.
	var push_notification_registrations: Array[PushNotificationRegistrationModel]
	## List of leaderboard statistic values for the player.
	var statistics: Array[StatisticModel]
	## List of player's tags for segmentation.
	var tags: Array[TagModel]
	## Title ID this player profile applies to.
	var title_id: String
	## Sum of the player's purchases made with real-money currencies, converted to US dollars equivalent and represented as a whole number of cents (1/100 USD). For example, 999 indicates nine dollars and ninety-nine cents.
	var total_value_to_date_in_usd: float
	## List of the player's lifetime purchase totals, summed by real-money currency.
	var values_to_date: Array[ValueToDateModel]

class StatisticValue extends PlayFabModel:
	## unique name of the statistic.
	var statistic_name: String
	## statistic value for the player.
	var value: float
	## for updates to an existing statistic value for a player, the version of the statistic when it was loaded.
	var version: float

## Indicates whether a given data key is private (readable only by the player) or public (readable by all players). When a player makes a GetUserData request about another player, only keys marked Public will be returned.
class UserDataPermission extends PlayFabModel:
	var private: String
	var public: String

class UserDataRecord extends PlayFabModel:
	## Timestamp for when this data was last updated.
	var last_updated: String
	## Indicates whether this data can be read by all users (public) or only the user (private). This is used for GetUserData requests being made by one player about another player.
	var permission: UserDataPermission
	## Data stored for the specified user data key.
	var value: String

class VirtualCurrencyRechargeTime extends PlayFabModel:
	## Maximum value to which the regenerating currency will automatically increment. Note that it can exceed this value through use of the AddUserVirtualCurrency API call. However, it will not regenerate automatically until it has fallen below this value.
	var recharge_max: float
	## Server timestamp in UTC indicating the next time the virtual currency will be incremented.
	var recharge_time: String
	## Time remaining (in seconds) before the next recharge increment of the virtual currency.
	var seconds_to_recharge: float

class GetPlayerCombinedInfoResultPayload extends PlayFabModel:
	## Account information for the user. This is always retrieved.
	var account_info: UserAccountInfo
	## Inventories for each character for the user.
	var character_inventories: Array[CharacterInventory]
	## List of characters for the user.
	var character_list: Array[CharacterResult]
	## The profile of the players. This profile is not guaranteed to be up-to-date. For a new player, this profile will not exist.
	var player_profile: PlayerProfileModel
	## List of statistics for this player.
	var player_statistics: Array[StatisticValue]
	## Title data for this title.
	var title_data: Dictionary
	## User specific custom data.
	var user_data: UserDataRecord
	## The version of the UserData that was returned.
	var user_data_version: float
	## Array of inventory items in the user's current inventory.
	var user_inventory: Array[ItemInstance]
	## User specific read-only data.
	var user_read_only_data: UserDataRecord
	## The version of the Read-Only UserData that was returned.
	var user_read_only_data_version: float
	## Dictionary of virtual currency balance(s) belonging to the user.
	var user_virtual_currency: Dictionary
	## Dictionary of remaining times and timestamps for virtual currencies.
	var user_virtual_currency_recharge_times: VirtualCurrencyRechargeTime

class UserSettings extends PlayFabModel:
	## Boolean for whether this player is eligible for gathering device info.
	var gather_device_info: bool
	## Boolean for whether this player should report OnFocus play-time tracking.
	var gather_focus_info: bool
	## Boolean for whether this player is eligible for ad tracking.
	var needs_attribution: bool

class Variable extends PlayFabModel:
	## Name of the variable.
	var name: String
	## Value of the variable.
	var value: String

class TreatmentAssignment extends PlayFabModel:
	## List of the experiment variables.
	var variables: Array[Variable]
	## List of the experiment variants.
	var variants: Array[String]

## The basic wrapper around every failed API response
class ApiErrorWrapper extends PlayFabModel:
	## Numerical HTTP code.
	var code: int
	## Playfab error code.
	var error: String
	## Numerical PlayFab error code.
	var error_code: int
	## Detailed description of individual issues with the request object.
	var error_details: Dictionary
	## Description for the PlayFab errorCode.
	var error_message: String
	## String HTTP code.
	var status: String

class PlayerProfileViewConstraints extends PlayFabModel:
	## Whether to show player's avatar URL. Defaults to false.
	var show_avatar_url: bool
	## Whether to show the banned until time. Defaults to false.
	var show_banned_until: bool
	## Whether to show campaign attributions. Defaults to false.
	var show_campaign_attributions: bool
	## Whether to show contact email addresses. Defaults to false.
	var show_contact_email_addresses: bool
	## Whether to show the created date. Defaults to false.
	var show_created: bool
	## Whether to show the display name. Defaults to false.
	var show_display_name: bool
	## Whether to show player's experiment variants. Defaults to false.
	var show_experiment_variants: bool
	## Whether to show the last login time. Defaults to false.
	var show_last_login: bool
	## Whether to show the linked accounts. Defaults to false.
	var show_linked_accounts: bool
	## Whether to show player's locations. Defaults to false.
	var show_locations: bool
	## Whether to show player's membership information. Defaults to false.
	var show_memberships: bool
	## Whether to show origination. Defaults to false.
	var show_origination: bool
	## Whether to show push notification registrations. Defaults to false.
	var show_push_notification_registrations: bool
	## Reserved for future development.
	var show_statistics: bool
	## Whether to show tags. Defaults to false.
	var show_tags: bool
	## Whether to show the total value to date in usd. Defaults to false.
	var show_total_value_to_date_in_usd: bool
	## Whether to show the values to date. Defaults to false.
	var show_values_to_date: bool

class GetPlayerCombinedInfoRequestParams extends PlayFabModel:
	## Whether to get character inventories. Defaults to false.
	var get_character_inventories: bool
	## Whether to get the list of characters. Defaults to false.
	var get_character_list: bool
	## Whether to get player profile. Defaults to false. Has no effect for a new player.
	var get_player_profile: bool
	## Whether to get player statistics. Defaults to false.
	var get_player_statistics: bool
	## Whether to get title data. Defaults to false.
	var get_title_data: bool
	## Whether to get the player's account Info. Defaults to false.
	var get_user_account_info: bool
	## Whether to get the player's custom data. Defaults to false.
	var get_user_data: bool
	## Whether to get the player's inventory. Defaults to false.
	var get_user_inventory: bool
	## Whether to get the player's read only data. Defaults to false.
	var get_user_read_only_data: bool
	## Whether to get the player's virtual currency balances. Defaults to false.
	var get_user_virtual_currency: bool
	## Specific statistics to retrieve. Leave null to get all keys. Has no effect if GetPlayerStatistics is false.
	var player_statistic_names: Array[String]
	## Specifies the properties to return from the player profile. Defaults to returning the player's display name.
	var profile_constraints: PlayerProfileViewConstraints
	## Specific keys to search for in the custom data. Leave null to get all keys. Has no effect if GetTitleData is false.
	var title_data_keys: Array[String]
	## Specific keys to search for in the custom data. Leave null to get all keys. Has no effect if GetUserData is false.
	var user_data_keys: Array[String]
	## Specific keys to search for in the custom data. Leave null to get all keys. Has no effect if GetUserReadOnlyData is false.
	var user_read_only_data_keys: Array[String]

class LoginResult extends PlayFabModel:
	## If LoginTitlePlayerAccountEntity flag is set on the login request the title_player_account will also be logged in and returned.
	var entity_token: EntityTokenResponse
	## Results for requested info.
	var info_result_payload: GetPlayerCombinedInfoResultPayload
	## The time of this user's previous login. If there was no previous login, then it's DateTime.MinValue.
	var last_login_time: String
	## True if the account was newly created on this login.
	var newly_created: bool
	## Player's unique PlayFabId.
	var play_fab_id: String
	## Unique token authorizing the user and game at the server level, for the current session.
	var session_ticket: String
	## Settings specific to this user.
	var settings_for_user: UserSettings
	## The experimentation treatments for this user at the time of login.
	var treatment_assignment: TreatmentAssignment