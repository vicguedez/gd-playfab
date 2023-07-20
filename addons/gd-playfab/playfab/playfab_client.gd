## REST APIs for PlayFab client management and services.
extends Node
class_name PlayFabClient

## Signs the user into the PlayFab account, returning a session identifier that can subsequently be used for API calls which require an authenticated user. Unlike most other login API calls, LoginWithEmailAddress does not permit the creation of new accounts via the CreateAccountFlag. Email addresses may be used to create accounts via RegisterPlayFabUser.
class LoginWithEmailAddress extends PlayFabHttpRequest:
	## Email address for the account.
	var email: String
	## Password for the PlayFab account (6-100 characters).
	var password: String
	## Flags for which pieces of info to return for the user.
	var info_request_parameters: PlayFabModel.GetPlayerCombinedInfoRequestParams
