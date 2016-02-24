[![](https://stateoftheart.creatubbles.com/wp-content/uploads/2015/01/ctb_home_logo.png)](https://www.creatubbles.com/)

[![Version](https://img.shields.io/cocoapods/v/creatubbles_api.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)
[![License](https://img.shields.io/cocoapods/l/creatubbles_api.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)
[![Platform](https://img.shields.io/cocoapods/p/creatubbles_api.svg?style=flat)](https://cocoapods.org/pods/CreatubblesAPIClient)

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
- [Nimble](https://pl.wikipedia.org/wiki/CompactFlash)

## Installation

CreatubblesAPIClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```Ruby
pod 'CreatubblesAPIClient'
```

## Usage (Swift)
```Swift
import CreatubblesAPIClient

let settings = CreatubblesAPIClientSettings(appId: "YOUR_APP_ID", appSecret: "YOUR_APP_SECRET")
let client = CreatubblesAPIClient(settings: settings)

client.login("username", password: "password")
{
  (error) -> (Void) in
  if error != nil
  {
    print("Wohoo! We're authorized!")
  }
}
```
## Usage (Objective-C)
Use methods with '_' prefix to communicate using Objective-C

```ObjectiveC
CreatubblesAPIClientSettings *settings = [[CreatubblesAPIClientSettings alloc] initWithAppId:@"YOUR_APP_ID" appSecret:@"YOUR_APP_SECRET"];
CreatubblesAPIClient *client = [[CreatubblesAPIClient alloc] initWithSettings:settings];
[client _login:@"username" password:@"password" completion:
^(NSError* error)
{
  if(!error)
  {
    NSLog(@"Wohoo! We're authorized from Objective-C code!");
  }
}];
```

## License

CreatubblesAPIClient is available under the [MIT license](https://github.com/creatubbles/ctb-api-swift/blob/master/LICENSE.md).
