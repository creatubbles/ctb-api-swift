# Objective-C Quickstart
- Initialization
- Login
- Fetching Creators
- Fetching galleries
- Fetching landing URLs
- Uploading creation

### Initialization
To initialize APIClient, first you have to import CreatubblesAPIClient framework:

```ObjectiveC
@import CreatubblesAPIClient;
```
Then, you can create `APIClientSettings` object. You will need OAuth application id and secret (please contact us to obtain your own keys).
There are two servers which are available for our partners: production and staging, but you can use same OAuth keys for communicating them.
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
With ready `APIClientSettings` instance, you can create `APIClient` object:
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

### Fetching creators
To fetch creators of a user, use a `[client _getCreators:...]` method:
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
- reflection text
- reflection video url
- gallery (gallery identifier)
- creators (creator identifiers)
- creation year
- creation month

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

And on this point you should be ready to upload creation.
```ObjectiveC
[client _newCreation:creationData completion: ^(Creation *creation, NSError *error)
{
  NSLog(@"Creation uploaded. Error %@",error);
}];
```
