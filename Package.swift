// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RudderBugsnag",
    platforms: [
        .iOS("13.0"), .tvOS("11.0"), .macOS("10.13")
    ],
    products: [
        .library(
            name: "RudderBugsnag",
            targets: ["RudderBugsnag"]
        )
    ],
    dependencies: [
        .package(name: "Bugsnag", url: "https://github.com/bugsnag/bugsnag-cocoa", "6.16.4"..<"6.16.5"),
        .package(name: "Rudder", url: "https://github.com/rudderlabs/rudder-sdk-ios", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "RudderBugsnag",
            dependencies: [
                .product(name: "Bugsnag", package: "Bugsnag"),
                .product(name: "Rudder", package: "Rudder"),
            ],
            path: "Sources",
            sources: ["Classes/"]
        )
    ]
)
