// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoritePrimes",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "FavoritePrimes Lib",
            targets: ["FavoritePrimes"]),
    ],
    dependencies: [
        .package(path: "../ComposableArchitecture")
    ],
    targets: [
        .target(
            name: "FavoritePrimes",
            dependencies: [
                .product(
                    name: "ComposableArchitecture Lib",
                    package: "ComposableArchitecture"
                )
            ]
        )
    ]
)
