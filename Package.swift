// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OGameServer",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "OGameServer",
            targets: ["OGameServer"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/christiankm/OGame", .branch("main")),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "1.0.0"),
        .package(url: "https://github.com/MaxDesiatov/XMLCoder", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "OGameServer",
            dependencies: [
                "OGame",
                "SwiftSoup",
                "XMLCoder"
            ]
        ),
        .testTarget(
            name: "OGameServerTests",
            dependencies: ["OGameServer"],
            resources: [
                .copy("OGame API Stubs/alliances.xml"),
                .copy("OGame API Stubs/highscore.xml"),
                .copy("OGame API Stubs/localization.xml"),
                .copy("OGame API Stubs/players.xml"),
                .copy("OGame API Stubs/player_data.xml"),
                .copy("OGame API Stubs/server_data.xml"),
                .copy("OGame API Stubs/universe.xml"),
                .copy("OGame API Stubs/universes.xml"),
              ]
        )
    ]
)
