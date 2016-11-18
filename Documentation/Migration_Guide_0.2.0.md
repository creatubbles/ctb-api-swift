## Migration Guide - 0.2.0

### Authentication

The latest version of CreatubblesAPIClient introduces a new approach to authentication process. From now on all methods, related to fetching data, require to call explicitly a method responsible for getting an access token.

There are two possibilities for the developers:

- If they want to fetch some data related to a particular user they need to call a `login(...)` method.

```Swift
client.login("username", password: "password")
{
  (error) -> (Void) in
  if error != nil
  {
    print("Success! You're authorized!")
  }
}
```

- If they want to fetch some not user-specific data like for example: `Landing URLs`, they will have to call a `authenticate(...)` method.

```Swift
client.authenticate
{
  (error) -> (Void) in
  if error != nil
  {
    print("Success! You're authorized!")
  }
}
```

Previously we were implicitly starting the authentication process during a initialization of a APIClient instance. Now it is a developer's responsibility to decide when it should be handled.

### Causes of these changes:

- The modifications have been made because of the fact we decided to remove some external libraries responsible for network communication (`Alamofire`) and OAuth support (`p2.OAuth`). We had some problem with migration to Swift 3 and we made a decision to not rely on these libraries anymore.
- Also we wanted to have a full control of the setup process using the public interface of `APIClient` to avoid a situation when something happens under the hood unintentionally.

To get more information about the integration, please check out our QuickStart Guide for [Swift](Documentation/Quickstart_Swift.md) or [Objective-C](Documentation/Quickstart_ObjectiveC.md).
