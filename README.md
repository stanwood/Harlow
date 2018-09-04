
# StanwoodCore framework

[![Swift Version](https://img.shields.io/badge/Swift-4.1.x-orange.svg)]()
[![iOS 10+](https://img.shields.io/badge/iOS-10+-EB7943.svg)]()

## Table of contents

- [Author](#author)
- [Installation](#installation)
- [Licence](#licence)


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
## Licence

StanwoodDebugger is under MIT licence. See the [LICENSE](https://github.com/stanwood/Stanwood_Debugger_iOS/blob/master/LICENSE.md) file for more info.

A brief summary of each StanwoodDebugger release can be found in the [CHANGELOG](https://github.com/stanwood/Stanwood_Debugger_iOS/blob/master/CHANGELOG.md).

