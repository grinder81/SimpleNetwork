// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleNetwork",
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .watchOS(.v3)
     ],
    products: [
        .library(name: "SimpleNetwork", targets: ["SimpleNetwork"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "SimpleNetwork",  dependencies: []),
        .testTarget(name: "SimpleNetworkTests", dependencies: ["SimpleNetwork"]),
    ]
)
