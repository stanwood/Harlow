// swift-tools-version:5.3
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
        .package(url: "https://github.com/scalessec/Toast-Swift.git", .exact("4.0.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Harlow",
            dependencies: ["Pulsator", "Toast-Swift"]),
        .testTarget(
            name: "HarlowTests",
            dependencies: ["Harlow"]),
    ]
)
