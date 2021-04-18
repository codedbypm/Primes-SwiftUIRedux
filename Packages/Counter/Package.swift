// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Counter",
    products: [
        .library(
            name: "Counter",
            targets: ["Counter"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Counter",
            dependencies: []),
        .testTarget(
            name: "CounterTests",
            dependencies: ["Counter"]
        ),
    ]
)
