// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ogame-server",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "OGameServer",
            targets: ["ogame-server"]),
    ],
    dependencies: [
        .package(url: "https://github.com/christiankm/OGame", .branchItem("main")),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "1.0.0")
        .package(url: "https://github.com/MaxDesiatov/XMLCoder", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "ogame-server",
            dependencies: [
                "OGame",
                "SwiftSoup"
                "XMLCoder"
            ]
        ),
        .testTarget(
            name: "ogame-serverTests",
            dependencies: ["ogame-server"]),
    ]
)
