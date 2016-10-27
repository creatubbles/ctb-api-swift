# Available Operations (doc in progress)
- Initialization settings
- [Authentication](https://github.com/Alamofire/Alamofire)
  - Login
  - Logout
  - Switching users
- Landing URLs
  - Supported landing URLs
  - Landing URL for Creation
  - Other Landing URLs
- Creator management
  - Fetching currently logged in user
  - Fetching single user by identifier
  - Fetching single user account data
  - Fetching creators
  - Fetching managers
  - Adding single Creator
  - Adding multiple Creators
  - Editing profile
- Gallery management
  - Fetching single gallery
  - Fetching galleries by creation
  - Fetching galleries by user
  - Fetching owned galleries
  - Fetching galleries shared with currently logged in user
  - Fetching favorite galleries of currently logged in user
  - Fetching featured galleries
  - Adding gallery
  - Editing gallery
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
  - Fetching users followed by user
- Partner Applications
- Reports
  - User
  - Gallery
  - Creation
  - Comment
- Batch fetching
  - Creators
  - Managers
  - Galleries

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
```Swift
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
#### Fetching currently logged in user
To fetch currently logged in user, use `getCurrentUser(...)` method:
```Swift
public func getCurrentUser(completion: UserClosure?) -> RequestHandler
```

#### Fetching single user by identifier
To fetch user by his identifier, use `getUser(...)` method:
```Swift
public func getUser(userId userId: String, completion: UserClosure?) -> RequestHandler
```

#### Fetching single user account data
Account data contains more detailed information about user. To fetch it, use `getUserAccountData(...)` method:
```Swift
public func getUserAccountData(userId userId: String, completion: UserAccountDetailsClosure?) -> RequestHandler
```
You can read more about account data [here](https://partners.creatubbles.com/api/#account-details)

#### Fetching Creators
To fetch creators of a user, use a `getCreators(...)` method:
```Swift
public func getCreators(userId userId: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
```

You can also fetch Creators from single group:
```Swift
public func getCreators(groupId groupId: String, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
```

#### Fetching Managers
To fetch managers (parents or teachers) of a creator, use a `getManagers(...)` method:
```Swift
public func getManagers(userId userId: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
```
If you pass `nil` as a userId, managers of currently logged in user will be returned.

#### Adding single Creator
To add single Creator, use `newCreator(...)` method.
```Swift
public func newCreator(data creatorData: NewCreatorData,completion: UserClosure?) -> RequestHandler
```

#### Adding multiple Creators
To add many Creators in single API call, use `createMultipleCreators(...)`.
Note that this method will allow you to set amount of Creators and their birth year only. Usernames will be generated based on your nickname, but Creators should be able to change them after they login.
```Swift
public func createMultipleCreators(data data: CreateMultipleCreatorsData, completion: ErrorClosure?) -> RequestHandler
```

#### Editing profile
To edit profile, use `editProfile(...)` method.
```Swift
public func editProfile(userId identifier: String, data: EditProfileData, completion: ErrorClosure?) -> RequestHandler
```
For data which can be edited see [Account Details](https://partners.creatubbles.com/api/#account-details) section of API Reference.

### Gallery management
#### Fetching single gallery
To fetch single gallery, use `getGallery(galleryId ...)` method.
```Swift
public func getGallery(galleryId galleryId: String, completion: GalleryClosure?) -> RequestHandler
```

#### Fetching galleries by creation
To fetch galleries by creation, use `getGalleries(creationId ...)` method.
```Swift
public func getGalleries(creationId creationId: String, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
```
In completion closure you will receive galleries which contains selected creation.

#### Fetching galleries by user
To fetch galleries by user, use `getGalleries(userId ...)` method.
```Swift
public func getGalleries(userId userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
```
In completion closure you will receive galleries owned by selected user. If you pass `nil` as a userId, you will receive galleries of currently logged in user.

#### Fetching owned galleries
To fetch galleries owned by currently logged in user, use `getMyOwnedGalleries(...)` method.
```Swift
public func getMyOwnedGalleries(pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
```
You can also fetch all owned galleries in bach mode: `getOwnedGalleriesInBatchMode(...)`
```Swift
public func getOwnedGalleriesInBatchMode(completion: GalleriesBatchClosure?) -> RequestHandler
```

#### Fetching galleries shared with currently logged in user
To fetch galleries owned shared with currently logged in user, use `getMySharedGalleries(...)` method.
```Swift
public func getMySharedGalleries(pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
```
You can also fetch shared galleries in batch mode: `getSharedGalleriesInBatchMode(...)`
```Swift
public func getSharedGalleriesInBatchMode(completion: GalleriesBatchClosure?) -> RequestHandler
```
#### Fetching favorite galleries of currently logged in user
To fetch favorite galleries of currently logged in user, use `getMyFavoriteGalleries(...)` method.
```Swift
public func getMyFavoriteGalleries(pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
```
You can also fetch favorite galleries in batch mode: `getFavoriteGalleriesInBatchMode(...)`
```Swift
public func getFavoriteGalleriesInBatchMode(completion: GalleriesBatchClosure?) -> RequestHandler
```

#### Fetching featured galleries
To fetch featured galleries, use `getFeaturedGalleries(...)` method.
```Swift
public func getFeaturedGalleries(pagingData: PagingData?, completion: GalleriesClosure?) -> RequestHandler
```
You can also fetch featured galleries in batch mode: `getFeaturedGalleriesInBatchMode(...)`
```Swift
public func getFeaturedGalleriesInBatchMode(completion: GalleriesBatchClosure?) -> RequestHandler
```

#### Adding gallery
You can add a gallery using `newGallery(...)` method.
```Swift
public func newGallery(data galleryData: NewGalleryData, completion: GalleryClosure?) -> RequestHandler
```

#### Editing gallery
For editing gallery, use `updateGallery(..)` method.
```Swift
public func updateGallery(data data: UpdateGalleryData, completion: ErrorClosure?) -> RequestHandler
```
For data which can be edited see [Gallery Details](https://partners.creatubbles.com/api/#gallery-details) section of API Reference.

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
