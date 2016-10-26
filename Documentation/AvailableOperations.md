# Available Operations
- Initialization settings
- [Authentication](https://github.com/Alamofire/Alamofire)
  - Login
  - Logout
  - Switching users
- Landing URL's
  - Supported landing URLs
  - Landing URL for Creation
  - Other Landing URLs
- Creators management
- Gallery management
- Creation management
- Upload Sessions
- Creation flow
- Background session
- Bubbles
- Groups
- Comments
- Content
- CustomStyle
- Activities
- Notifications
- User Followings
- Partner Applications

### Initialization settings
### Authentication

#### Login
To login, call `login` method, with username and password passed as parameters.
```Swift
public func login(username username: String, password: String, completion:ErrorClosure?)
```

#### Logout
To logout, call `logout` method. It will remove all tokens stored in APIClient, also `creatubblesAPIClientUserChanged(...)` delegate method will be called.
```Swift
public func logout()
```
#### Switching users (without password)
Switching user without password is a bit more complicated operation.
You can fetch all users which you can login to using:
```Switf
public func getSwitchUsers(pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
```
Next, use `switchUser(...)` method to obtain OAuth token for user which would you like to login as.
```Swift
public func switchUser(targetUserId targetUserId: String, accessToken: String, completion: SwitchUserClosure?) -> RequestHandler
```

After this, you should have enough data to call `setSessionData(...)` method, which will switch OAUth tokens.
```Swift
public func setSessionData(data sessionData: SessionData)
```
### Landing URL's
#### Supported landing URLs
We're supporting fetching landing urls for:
- About us
- Terms of use
- Privacy policy
- Registration
- User profile
- Explore
- Creation
- Forgot password
- Upload guidelines
- Account dashboard

#### Landing URL for Creation
For Creation landing URL, please use:
```Swift
public func getLandingURL(creationId creationId: String, completion: LandingURLClosure?) -> RequestHandler
```
#### Other Landing URLs
For other types of landing urls, use:
```Swift
public func getLandingURL(type type: LandingURLType?, completion: LandingURLClosure?) -> RequestHandler
```

### Creators management
### Gallery management
### Creation management
### Upload Sessions
### Creation flow
### Background session
### Bubbles
### Groups
### Comments
### Content
### CustomStyle
### Activities
### Notifications
### User Followings
### Partner Applications
