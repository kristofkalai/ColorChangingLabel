// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ColorChangingLabel",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ColorChangingLabel",
            targets: ["ColorChangingLabel"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/stateman92/LayerAnimation.git", exact: .init(0, 0, 1))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ColorChangingLabel",
            dependencies: ["LayerAnimation"],
            path: "Sources"),
        .testTarget(
            name: "ColorChangingLabelTests",
            dependencies: ["ColorChangingLabel"]),
    ]
)
