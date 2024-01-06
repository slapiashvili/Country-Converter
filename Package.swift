// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CountryConverter",
    platforms: [
        .iOS(.v14), 
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CountryConverter",
            targets: ["CountryConverter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CountryConverter",
            dependencies: []),
        .testTarget(
            name: "CountryConverterTests",
            dependencies: ["CountryConverter"]),
    ]
)
