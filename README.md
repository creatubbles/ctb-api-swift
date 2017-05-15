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
## Migration to 0.2.0

Please check out our [Migration Guide](Documentation/Migration_Guide_0.2.0.md) to get more information.

## QuickStart
After installation you can start using APIClient. See QuickStart for [Swift](Documentation/Quickstart_Swift.md) or [Objective-C](Documentation/Quickstart_ObjectiveC.md) for first steps with library.

## Demo
We also have a demo, explained more [here](Documentation/OAuthDemo.md)

## Objective-C API Client
Feel free to use our own CTAPIClient wrapper for your Objective-C projects. You can check it out [here](https://github.com/creatubbles/ctb-api-swift/tree/develop/ObjectiveC_APIClient)

## Changelog
Detailed information about changes in APIClient are available [here](Documentation/changelog.md)

## Contact
In order to receive your AppId and AppSecret please contact us at <support@creatubbles.com>.

## License

CreatubblesAPIClient is available under the [MIT license](https://github.com/creatubbles/ctb-api-swift/blob/master/LICENSE.md).
