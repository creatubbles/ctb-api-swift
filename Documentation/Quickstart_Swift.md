# Swift QuickStart
- [Initialization](#initialization)
- [Login](#login)
- [Fetching Creators](#fetching-creators)
- [Fetching galleries](#fetching-galleries)
- [Fetching landing URLs](#fetching-landing-urls)
- [Uploading creation](#uploading-creation)

### Initialization
To initialize the APIClient, first you have to import CreatubblesAPIClient framework:
```Swift
import CreatubblesAPIClient
```
Then, you can create the `APIClientSettings` object. You will need the OAuth application's id and secret (please contact us to obtain your own keys).
There are two servers which are available for our partners: production and staging, but you can use the same OAuth keys to communicate with both of them.
```Swift
let productionSettings = APIClientSettings(appId: "YOUR_APP_ID",
                                           appSecret: "YOUR_APP_SECRET",
                                           backgroundSessionConfigurationIdentifier:"BACKGROUND_SESSION_IDENTIFIER" //Optional pass it to support background uploads.
                                           )
```
Connecting to staging server requires some more detailed information:

```Swift
let stagingSettings = APIClientSettings(appId: "YOUR_APP_ID",
                                        appSecret: "YOUR_APP_SECRET"",
                                        tokenUri: "https://api.creatubbles.com/v2/oauth/token",
                                        authorizeUri: "https://api.creatubbles.com/v2/oauth/token",
                                        baseUrl: "https://api.creatubbles.com",
                                        apiVersion: "v2",
                                        locale: "en",   //Optional, see https://partners.creatubbles.com/api/#locales for supported locales
                                        backgroundSessionConfigurationIdentifier:"BACKGROUND_SESSION_IDENTIFIER"  //Optional
                                        )
```
With a prepared `APIClientSettings` instance, you can create an `APIClient` object:
```Swift
let settings = APIClientSettings(...)
let client = APIClient(settings: settings)
```
### Login
```Swift
client.login("username", password: "password")
{
  (error) -> (Void) in
  if error != nil
  {
    print("Wohoo! We're authorized!")
  }
}
```

### Authentication
To be able to fetch some relevant data you will have to complete authentication process before you execute any other request. You can use a login method described above to achieve it. There is also alternative way to get an access to resources (without passing a username and password) by invoking a `authenticate(...)` method:
```Swift
client.authenticate
{
  (error) -> (Void) in
  if error != nil
  {
    print("Wohoo! We're authorized!")
  }
}
```

### Fetching creators
To fetch user’s creators, use the `getCreators(...)` method:
```Swift
public func getCreators(userId userId: String?, pagingData: PagingData?, completion: UsersClosure?) -> RequestHandler
```

or fetch them in batch mode (which may take some time):
```Swift
public func getCreatorsInBatchMode(userId userId: String?, completion: UsersBatchClosure?) -> RequestHandler
```

If you pass the userId as `nil`, creators of currently logged in user will be returned.

### Fetching galleries
To fetch galleries by user, use `getGalleries(userId ...)` method.
```Swift
public func getGalleries(userId userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
```
Or in batch mode
```Swift
func getGalleriesInBatchMode(userIdentifier userId: String?, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
```
In completion closure you will receive galleries owned by the selected user. If you pass `nil` as a userId, you will receive galleries of the currently logged in user.

### Fetching landing URLs
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

For Creation landing URL, please use:
```Swift
public func getLandingURL(creationId creationId: String, completion: LandingURLClosure?) -> RequestHandler
```

For other types of landing urls, use:
```Swift
public func getLandingURL(type type: LandingURLType?, completion: LandingURLClosure?) -> RequestHandler
```

### Uploading creation
To upload a creation, create `NewCreationData` object. You can create it with binary blob (`NSData`), image (`UIImage`), or URL to local file (`NSURL`). Also you have to specify type (extension) of uploaded creation. We're supporting following extensions:
- PNG
- JPG
- JPEG
- H264
- MPEG4
- WMV
- WEBM
- FLV
- OGG
- OGV
- MP4
- M4V
- MOV
- UZPB

Example:
```Swift
//UIImage
let creationData = NewCreationData(image: UIImage(named:"demo")!, uploadExtension: .PNG)

//NSData
let path = NSBundle.mainBundle().URLForResource("demo", withExtension: "mp4")!
let data = NSData(contentsOfURL: path)!
let creationData = NewCreationData(data: data, uploadExtension: .MP4)

//URL
let path = NSBundle.mainBundle().URLForResource("demo", withExtension: "mp4")!
let creationData = NewCreationData(path: path, uploadExtension: .MP4)
```
In `NewCreationData` object you can set:
- name
- creationIdentifier
- localIdentifier
- reflection text
- reflection video url
- gallery (gallery identifier)
- creators (creator identifiers)
- creation year
- creation month

The `creationIdentifier` property is responsible for editing an existing creation.

Also please be aware of the usage of `localIdentifier`. It could be useful in you want to improve management process of creations. In this case you will need to make sure that this identifier is unique. `CreatubblesAPIClient` framework returns error if there are more than one creation with the same `localIdentifier` property.

```Swift
let creationData = NewCreationData(...)
creationData.name = "My Name"
creationData.reflectionText = "Creation description"
creationData.reflectionVideoUrl  = "https://www.youtube.com/watch?v=f8YGyXoihMQ"
creationData.gallery = "SelectedGalleryIdentifier"
creationData.creatorIds = ["Creator1Id", "Creator2Id"]
creationData.creationYear = 2015
creationData.creationMonth = 10
```

At this point you should be ready to upload creation.
```Swift
apiClient.newCreation(data: creationData)
{
  (creation, error) -> (Void) in
  print("Creation uploaded. Error: \(error)")
}
```

### Error handling
Error handling is based on http://jsonapi.org/format/#error-objects.
Most methods may provide an `APIClientError` in completion block. Example:

```
getSuggestedAvatars()
{   
  (avatarSuggestions: Array<AvatarSuggestion>?, error: APIClientError?) -> (Void) in
  //Do stuff
}
```
The `APICLientError` object has following non-optional fields:
```Swift
open let status: Int
open let code: String
open let title: String
open let source: String
open let detail: String
open let domain: String
```
If any of those fields is not returned in the server's response, then following default values are used:
```Swift
public static let DefaultDomain: String = "com.creatubbles.apiclient.errordomain"
public static let DefaultStatus: Int    = -6000
public static let DefaultCode:   String = "creatubbles-apiclient-default-code"
public static let DefaultTitle:  String = "creatubbles-apiclient-default-title"
public static let DefaultSource: String = "creatubbles-apiclient-default-source"
public static let DefaultDetail: String = "creatubbles-apiclient-default-detail"
```
You can recognize what kind of error you received based on it's `status` property:
```
1      Unknown - The operation couldn’t be completed.
400	Bad request - you requested a resource which returned validation errors
401	Not authorized – Access Token is invalid
403	Forbidden – Accessing forbidden resources. When trying to access restricted area.
404	Not Found – When object in the database cannot be found.
406	Not Acceptable – You requested a format that isn’t json
422	Validation error - You try to create/update a resource with invalid params
429	Too Many Requests – You’re requesting too many kittens! Slow down!
500	Internal Server Error – We had a problem with our server. Try again later.
503	Service Unavailable – We’re temporarially offline for maintanance. Please try again later.
```
There are also some additional APIClient error codes available:
```
-6001   UnknownStatus
-6002   LoginStatus
-6003   UploadCancelledStatus
-6004   MissingResponseDataStatus
-6005   InvalidResponseDataStatus
-6006   DuplicatedUploadLocalIdentifierStatus
```
