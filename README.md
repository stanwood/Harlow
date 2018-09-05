
# StanwoodCore framework

[![Swift Version](https://img.shields.io/badge/Swift-4.1.x-orange.svg)]()
[![iOS 10+](https://img.shields.io/badge/iOS-10+-EB7943.svg)]()

Debugging and testing iOS applications can be quite a long task due to the nature of Software Development. _StanwoodDebugger_ tool provides reach information on Analytics, Errors, Logging, Networking, and UITesting to simplify this process.


<img src="Media/stanwood_debugger.gif" alt="Module" width="300">


## Table of contents

- [Author](#author)
- [Installation](#installation)
- [Usage](#usage)
- [Licence](#licence)
- [Changelog](#changelog)


## Author

Tal Zion tal.zion@stanwood.io

## Installation

```ruby
pod 'StanwoodDebugger', :configurations => ['Debug'] # Make sure to not add this framework to Release
```

## Usage

```swift
#if DEBUG
import StanwoodDebugger
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    #if DEBUG
    lazy var debugger: StanwoodDebugger = StanwoodDebugger()
    #endif

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
        debugger.isEnabled = true
        #endif
    }
}
```

## Adding logs

### Analytics

##### Option 1.

Set up your tracking payload:

```swift
public func payload() -> [String:String] {

    var payload: [String:String] = ["eventName": eventName]
    
    if let itemId = itemId {
        payload["itemId"] = itemId
    }
    
    if let category = category {
        payload["category"] = category
    }

    if let contentType = contentType {
        payload["contentType"] = contentType
    }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    payload["createdAt"] = dateFormatter.string(from: Date())
    
    return payload
}
```
Post it to:

```swift
func post(_ payload: [String:String]) {
    let notificationCentre = NotificationCenter.default
    let notification = Notification.init(name: Notification.Name(rawValue: "io.stanwood.debugger.didReceiveAnalyticsItem"), object: nil, userInfo: payload)
    notificationCentre.post(notification)
}
```


##### Option 2.

Use [StanwoodAnalytics](https://github.com/stanwood/Stanwood_Analytics_iOS) as your tracking framework

### Error, UITesing, Networking, Print logs **[WIP]**

## Licence

StanwoodDebugger is under MIT licence. See the [LICENSE](https://github.com/stanwood/Stanwood_Debugger_iOS/blob/master/LICENSE.md) file for more info.

## Changelog

A brief summary of each StanwoodDebugger release can be found in the [CHANGELOG](https://github.com/stanwood/Stanwood_Debugger_iOS/blob/master/CHANGELOG.md).

