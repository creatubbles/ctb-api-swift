# Objective-C QuickStart
- [Initialization](#initialization)
- [Login](#login)
- [Fetching Creators](#fetching-creators)
- [Fetching galleries](#fetching-galleries)
- [Fetching landing URLs](#fetching-landing-urls)
- [Uploading creation](#uploading-creation)

### Initialization
To initialize APIClient, first you have to import CreatubblesAPIClient framework:

```ObjectiveC
@import CreatubblesAPIClient;
```
Then, you can create `APIClientSettings` object. You will need OAuth application id and secret (please contact us to obtain your own keys).
There are two servers which are available for our partners: production and staging, but you can use the same OAuth key to communicate with both of them.
```ObjectiveC
APIClientSettings *productionSettings = [[APIClientSettings alloc] initWithAppId:@"YOUR_APP_ID"
                                                                       appSecret:@"YOUR_APP_SECRET"
                                        backgroundSessionConfigurationIdentifier:@"BACKGROUND_SESSION_IDENTIFIER"];
```

Connecting to staging server requires some more detailed information:
```ObjectiveC
APIClientSettings *settings = [[APIClientSettings alloc] initWithAppId:@"YOUR_APP_ID"
                                                            appSecret:@"YOUR_APP_SECRET"
                                                             tokenUri:@"https://api.staging.creatubbles.com/v2/oauth/token"
                                                         authorizeUri:@"https://api.staging.creatubbles.com/v2/oauth/token"
                                                              baseUrl:@"https://api.staging.creatubbles.com"
                                                           apiVersion:@"v2"
                             backgroundSessionConfigurationIdentifier:@"BACKGROUND_SESSION_IDENTIFIER"];    
```
With a prepared `APIClientSettings` instance, you can create the `APIClient` object:
```ObjectiveC
APIClientSettings *settings = [][APIClientSettings alloc] initWithAppId...];
APIClient *client = [[APIClient alloc] initWithSettings:settings];
```

### Login
```ObjectiveC
[client _login:@"username" password:@"password" completion:
^(NSError* error)
{
 if(!error)
 {
   NSLog(@"Wohoo! We're authorized from Objective-C code!");
 }
}];
```

### Authentication
To be able to fetch some relevant data you will have to complete authentication process before you execute any other request. You can use a login method described above to achieve it. There is also alternative way to get an access to resources (without passing a username and password) by invoking a `[client _authenticateWithCompletion:...]` method:
```ObjectiveC
[client _authenticateWithCompletion:
^(NSError* error)
{
 if(!error)
 {
   NSLog(@"Wohoo! We're authorized from Objective-C code!");
 }
}];
```

### Fetching creators
To fetch user's creators, use a `[client _getCreators:...]` method:
```ObjectiveC
- (void) _getCreators:(NSString * _Nullable)userId pagingData:(PagingData * _Nullable)pagingData completion:(void (^ _Nullable)(NSArray<User *> * _Nullable, PagingInfo * _Nullable, NSError * _Nullable))completion;
```

or fetch them in batch mode (which may take some time):
```ObjectiveC
- (void) _getCreatorsInBatchMode:(NSString * _Nullable)userId completion:(void (^ _Nullable)(NSArray<User *> * _Nullable, NSError * _Nullable))completion;
```

If you pass `nil` as a userId, creators of currently logged in user will be returned.

### Fetching galleries
To fetch galleries by user, use `[client _getGalleries:...]` method.
```ObjectiveC
public func getGalleries(userId userId: String?, pagingData: PagingData?, sort: SortOrder?, completion: GalleriesClosure?) -> RequestHandler
```
Or in batch mode
```ObjectiveC
func getGalleriesInBatchMode(userIdentifier userId: String?, sort: SortOrder?, completion: GalleriesBatchClosure?) -> RequestHandler
```
In completion closure you will receive galleries owned by selected user. If you pass `nil` as a userId, you will receive galleries of currently logged in user.

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
```ObjectiveC
- (void)_getLandingURLForCreation:(NSString * _Nonnull)creationId completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;
```

For other types of landing urls, use:
```ObjectiveC
- (void)_getLandingURL:(enum LandingURLType)type completion:(void (^ _Nullable)(NSArray<LandingURL *> * _Nullable, NSError * _Nullable))completion;
```

### Uploading creation
To upload creation, create `NewCreationData` object. You can create it with binary blob (`NSData`), image (`UIImage`), or URL to local file (`NSURL`). Also you have to specify type (extension) of uploaded creation. We're supporting following extensions:
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
```ObjectiveC
//UIImage
NewCreationData *creationData = [NewCreationData alloc] initWithImage:[UIImage imageNamed:@"demo"] uploadExtension:UploadExtensionJPG];

//NSData
NSURL *path = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"mp4"];
NSData *data = [NSData dataWithContentsOfURL:path];
NewCreationData *creationData = [[NewCreationData alloc] initWithData:data uploadExtension:UploadExtensionMP4];

//URL
NSURL *path = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"mp4"];
NewCreationData *creationData = [[NewCreationData alloc] initWithUrl:path uploadExtension:UploadExtensionMP4];
```
On `NewCreationData` object you can set:
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

```ObjectiveC
NewCreationData *creationData = [[NewCreationData alloc] initWith...];
creationData.name = @"My Name";
creationData.reflectionText = @"Creation description";
creationData.reflectionVideoUrl  = @"https://www.youtube.com/watch?v=f8YGyXoihMQ";
creationData.gallery = @"SelectedGalleryIdentifier";
creationData.creatorIds = @[@"Creator1Id", @"Creator2Id"];

[creationData setCreationYear:@(2015)];
[creationData setCreationMonth:@(10)];
```

At this point you should be ready to upload a creation
```ObjectiveC
[client _newCreation:creationData completion: ^(Creation *creation, NSError *error)
{
  NSLog(@"Creation uploaded. Error %@",error);
}];
```

### Error handling
Most methods may provide an `NSError` in completion block. Example:

```ObjectiveC
[apiClient _getSuggestedAvatarsWithCompletion:^(NSArray<AvatarSuggestion *> *avatarSuggestions, NSError * error)
{
  if(error)
  {
    NSLog(error.localizedDescription);
  }
}];
```

The error object has access to standard NSError properties, like:
```ObjectiveC
@property (readonly, copy) NSErrorDomain domain;
@property (readonly) NSInteger code;
@property (readonly, copy) NSDictionary *userInfo;
@property (readonly, copy) NSString *localizedDescription;
```

You can recognize what kind of error you received based on it's `code` property:

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
