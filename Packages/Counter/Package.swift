// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Counter",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "Counter Lib",
            targets: ["Counter"]),
    ],
    dependencies: [
        .package(path: "../ComposableArchitecture")
    ],
    targets: [
        .target(
            name: "Counter",
            dependencies: [
                .product(
                    name: "ComposableArchitecture Lib",
                    package: "ComposableArchitecture"
                )
            ]
        )
    ]
)
