
![banner](assets/banner.png)

[![Swift Version](https://img.shields.io/badge/Swift-5.x-orange.svg)]()
[![iOS 10+](https://img.shields.io/badge/iOS-10+-EB7943.svg)]() [![Maintainability](https://api.codeclimate.com/v1/badges/1a2096a936f5ea9548ac/maintainability)](https://codeclimate.com/github/stanwood/Harlow/maintainability)
[![Build Status](https://travis-ci.org/stanwood/Harlow.svg?branch=master)](https://travis-ci.org/stanwood/Harlow)
Debugging and testing iOS applications can be quite a long task due to the nature of Software Development. _Harlow_ tool provides reach information on Analytics, Errors, Logging, Networking, and UITesting to simplify this process.

[![Demo Harlow](https://j.gifs.com/Q0ZWr9.gif)]()

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
pod 'Harlow', :configurations => ['Debug'] # Make sure to only use Harlow for development only.
```

## Usage

```swift
#if DEBUG
import Harlow
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    #if DEBUG
    lazy var debugger: Harlow = Harlow()
    #endif

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
        debugger.isEnabled = true
        #endif
    }
}
```

### Other options

```swift
debugger.isDebuggingDataPersistenceEneabled = true /// Enables local data persistance
debugger.enabledServices: [Service] = [.logs, .errors] /// The services you would like to enable. Default is se to `allCases`
debugger.tintColor = .red /// Change the tint color
debugger.errorCodesExceptions = [4097] /// Add error code exceptions
debugger.isShakeEnabled = true // Defaults to `true`. When this is `true`, shaking the device will enable/disable the Debugger
debugger.isEnabled = true
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

    if let screenName = screenName {
        payload["screenName"] = screenName
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

```swift
#if DEBUG
analyticsBuilder = analyticsBuilder.setDebuggerNotifications(enabled: true)
#endif
```

### Networking

`Harlow` works by default with `URLSessiosn.shared` and request are beeing logged for free. You can also register a custom condiguration: 

```swift
let configuration = URLSessionConfiguration.waitsForConnectivity

debugger.regsiter(custom: configuration)

/// Use with URLSession || any networking libraries such as Alamofire and Moya
let session = URLSession(configuration: configuration)
```

<img src="Media/stanwood_debugger_networking.gif" alt="Module" width="300">

### Error

`Harlow` will log `NSError` by default.  To add log exceptions:

```swift
debugger.errorCodesExceptions = [4097] /// Add error code exceptions
```

### Logs

`Harlow` will log `print` && `debugPrint` by default.

#### Configuration:

1. Create a new `Bridging-Header` file and add `-DEBUG` suffix

![logs-1](Media/logs-1.png)

2. Import `Harlow`

```objc
@import Harlow;
```

>Note: Make sure to add any other imported libraries from your main header file

3. Set `Bridging-Header-DEBUG.h` in the relevant configurations in the build settings.

![logs-3](Media/logs-3.png)

### Crashes

`Harlow` will log `Signal` and `NSException` crashes by default.

## Licence

Harlow is under MIT licence. See the [LICENSE](https://github.com/stanwood/Harlow/blob/master/LICENSE.md) file for more info.

## Changelog

A brief summary of each Harlow release can be found in the [CHANGELOG](https://github.com/stanwood/Harlow/blob/master/CHANGELOG.md).

