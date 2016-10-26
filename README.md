[![](https://stateoftheart.creatubbles.com/wp-content/uploads/2015/01/ctb_home_logo.png)](https://www.creatubbles.com/)

[![Version](https://img.shields.io/cocoapods/v/CreatubblesAPIClient.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)
[![License](https://img.shields.io/cocoapods/l/CreatubblesAPIClient.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)
[![Platform](https://img.shields.io/cocoapods/p/CreatubblesAPIClient.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)

## Creatubbles API Client
CreatubblesAPIClient is a simple library built to help you communicate with the latest [Creatubbles API](https://stateoftheart.creatubbles.com/api/). It works with both Swift and Objective-C.

Please note, that library is still under heavy development, and interface may be slightly changed.

## Author
[Creatubbles](https://www.creatubbles.com/)

## Dependencies
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [OAuth2](https://github.com/p2/OAuth2)
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
- [XCGLogger](https://github.com/DaveWoodCom/XCGLogger)
- [Quick](https://github.com/Quick/Quick)
- [Nimble](https://github.com/Quick/Nimble)

## Installation

CreatubblesAPIClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```Ruby
use_frameworks!

pod 'CreatubblesAPIClient'
```
or to use development version:
```Ruby
 pod 'CreatubblesAPIClient', :git => 'https://github.com/creatubbles/ctb-api-swift.git', :branch => 'develop'
```

## Available Operations
See [Available Operations](AvailableOperations.md) for a list of supported endpoints in APIClient, with more detailed examples of usage.

## Initialization (Swift)
To initialize APIClient, first you have to import CreatubblesAPIClient framework:
```Swift
import CreatubblesAPIClient
```
Then, you can create `APIClientSettings` object. You will need OAuth application id and secret (please contact us for your own keys).
There are two servers which are available for our partners: production and staging, but you can use same OAuth keys for communicating them.
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
With ready `APIClientSettings` instance, you can create `APIClient` object:
```Swift
let settings = APIClientSettings(...)
let client = APIClient(settings: settings)
```
and login:
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

## Initialization (Objective-C)
Initialization in Objective-C is very similar to Swift. First import `CreatubblesAPIClient` framework:
```ObjectiveC
@import CreatubblesAPIClient;
```
Production config:
```ObjectiveC
APIClientSettings *settings = [[APIClientSettings alloc] initWithAppId:@"YOUR_APP_ID"
                                                             appSecret:@"YOUR_APP_SECRET"
                              backgroundSessionConfigurationIdentifier:@"BACKGROUND_SESSION_IDENTIFIER"];

```
Staging config:
```ObjectiveC
APIClientSettings *settings = [[APIClientSettings alloc] initWithAppId:@"YOUR_APP_ID"
                                                             appSecret:@"YOUR_APP_SECRET"
                                                              tokenUri:@"https://api.staging.creatubbles.com/v2/oauth/token"
                                                          authorizeUri:@"https://api.staging.creatubbles.com/v2/oauth/token"
                                                               baseUrl:@"https://api.staging.creatubbles.com"
                                                            apiVersion:@"v2"
                              backgroundSessionConfigurationIdentifier:@"BACKGROUND_SESSION_IDENTIFIER"];    
```
APIClient initialization:
```ObjectiveC
APIClientSettings *settings = [][APIClientSettings alloc] initWithAppId...];
APIClient *client = [[APIClient alloc] initWithSettings:settings];
```
and login:
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

## Objective-C API Client
Feel free to use our own CTAPIClient wrapper for your Objective-C projects. You can check it out [here](https://github.com/creatubbles/ctb-api-swift/tree/develop/ObjectiveC_APIClient)

## Contact
In order to receive your AppId and AppSecret please contact us at <support@creatubbles.com>.

## License

CreatubblesAPIClient is available under the [MIT license](https://github.com/creatubbles/ctb-api-swift/blob/master/LICENSE.md).
