# gd-playfab

Godot 4 addon for Microsoft's PlayFab written in GDScript

> :warning: **This addon is still a work in progress.**
> 
> :warning: **This addon has only been tested in Godot 4.1.1.stable.**

## Objective

The idea behind this addon is to have a native Godot sdk, that is as tightly integrated as possible while reducing the amount of duplicated models and allowing the addition of new ones without modifying the plugin.

## Using

1. Copy `addons` to the root of your project.
2. Activate the plugin by going to `Project -> Settings -> Plugins`, click enable for `PlayFab`.
3. Before using the SDK, set your title id in code like so: `PlayFabSettings.title_id = "XXXXX"`.

You can delete the SDKs that you don't need once the addon has been copied. Let's say you don't need the Economy sdk, delete `playfab_economy.gd` and `playfab_economy_model.gd` which you can find at `addons/gd-playfab/playfab/`, this way your intellisense and help search doesn't get cluttered with useless classes.

## Sample code

```gdscript
func _ready() -> void:
    # Replace with your own title id.
	PlayFabSettings.title_id = "XXXXX" 
	
    # To get full intellisense on newly created request, use the
    # syntax var request := PlayFabX.MethodX.new() as PlayFabX.MethodX
    # this is a quirk 
	var login := PlayFabClient.LoginWithEmailAddress.new() as PlayFabClient.LoginWithEmailAddress
	
	login.email = "jhon@doe.com"
	login.password = "password"
	
    if login.send() != OK:
		print("Login no send")
		return
	
	await login.finished
	
	if login.has_error():
		print("Login has error")
		return
	
    # Login result model is automatically created and parsed from the response.
	var login_result := login.get_response_data()
	
    # Store current credentials to be used by following requests.
    PlayFabSettings.store_credentials_from_login_result(login_result)
	
	var get_inventory := PlayFabEconomy.GetIventoryItems.new() as PlayFabEconomy.GetIventoryItems
	
	get_inventory.count = 10
	
	if get_inventory.send() != OK:
		printt("Get inventory no send")
		return
	
	await get_inventory.finished
	
	if get_inventory.has_error():
		print("Get inventory has error")
		return
	
	var get_inventory_result := get_inventory.get_response_data()
	
	for item in get_inventory_result.items:
		print(item.display_properties)
```

## Docs

All clases and methods are documented using GDScript's doc comments. You can search and read them in-editor like the rest of GDScript's classes and types.