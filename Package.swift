// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ogame-server",
    platforms: [.macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "OGameServer",
            targets: ["ogame-server"]),
    ],
    dependencies: [
        .package(url: "https://github.com/christiankm/OGame", .branchItem("main")),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ogame-server",
            dependencies: [
                "OGame",
                "SwiftSoup"
            ]),
        .testTarget(
            name: "ogame-serverTests",
            dependencies: ["ogame-server"]),
    ]
)
