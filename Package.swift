// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Harlow",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Harlow",
            targets: ["Harlow"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/shu223/Pulsator.git", .upToNextMajor(from: "0.6.3")),
        .package(url: "https://github.com/schmidyy/Loaf.git", .upToNextMajor(from: "0.7.0")),
        .package(url: "https://github.com/stanwood/SourceModel_iOS.git", .upToNextMajor(from: "1.3.3"))
    ],
    targets: [
        .target(
            name: "Harlow",
            dependencies: ["Pulsator", "SourceModel", "Loaf"]),
        .testTarget(
            name: "HarlowTests",
            dependencies: ["Harlow"]),
    ],
    swiftLanguageVersions: [.v5]
)
