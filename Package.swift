// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMKeyboardManager",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "TMKeyboardManager",
            targets: ["TMKeyboardManager"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TMKeyboardManager",
            dependencies: []),
        .testTarget(
            name: "TMKeyboardManagerTests",
            dependencies: ["TMKeyboardManager"]),
    ]
)
