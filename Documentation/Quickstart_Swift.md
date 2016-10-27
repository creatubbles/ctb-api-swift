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
- reflection text
- reflection video url
- gallery (gallery identifier)
- creators (creator identifiers)
- creation year
- creation month

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
