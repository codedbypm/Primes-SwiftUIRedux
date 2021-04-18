// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PrimeModal",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "PrimeModal Lib",
            targets: ["PrimeModal"]),
    ],
    dependencies: [
        .package(path: "../ComposableArchitecture")
    ],
    targets: [
        .target(
            name: "PrimeModal",
            dependencies: [
                .product(
                    name: "ComposableArchitecture Lib",
                    package: "ComposableArchitecture"
                )
            ]
        )
    ]
)
