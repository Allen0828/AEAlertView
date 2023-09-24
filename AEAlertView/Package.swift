// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "AEAlertView",
    platforms: [.iOS(.v12), .macOS(.v10_14), .tvOS(.v12), .watchOS(.v5), .visionOS(.v1)],
    products: [
        .library(name: "AEAlertView", targets: ["AEAlertView"])
    ],
    targets: [
        .target(
            name: "AEAlertView",
            path: "Sources"
        )
    ]
)

