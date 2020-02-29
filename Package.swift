// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleNetwork",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SimpleNetwork",
            targets: ["SimpleNetwork"]),
    ],
    targets: [
        .target(
            name: "SimpleNetwork",
            dependencies: []),
        .testTarget(
            name: "SimpleNetworkTests",
            dependencies: ["SimpleNetwork"]),
    ],
    swiftLanguageVersions: [
        .version("5.1")
    ]
)
