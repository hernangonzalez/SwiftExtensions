// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftBaseSDK",
    products: [
        .library(
            name: "SwiftBaseSDK",
            targets: ["SwiftExtensions", "Logger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "5.0.0"),
        .package(url: "https://github.com/DaveWoodCom/XCGLogger.git", from: "6.1.0")
    ],
    targets: [
        .target(
            name: "Logger",
            dependencies: ["XCGLogger"]),
        .target(
            name: "SwiftExtensions",
            dependencies: ["ReactiveSwift", "Logger"])
    ]
)
