// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "WanaKana",
    products: [
        .library(
            name: "WanaKana",
            targets: ["WanaKana"]),
        .library(
            name: "CLIUtils",
            targets: ["CLIUtils"]),
        .executable(
            name: "tokana",
            targets: ["ToKana"]),
        .executable(
            name: "toromaji",
            targets: ["ToRomaji"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ToKana",
            dependencies: ["WanaKana", "CLIUtils"]),
        .target(
            name: "ToRomaji",
            dependencies: ["WanaKana", "CLIUtils"]),
        .target(
            name: "CLIUtils",
            dependencies: []),
        .target(
            name: "WanaKana",
            dependencies: [],
            resources: [
                .copy("Resources/wanakana.js"),
                ]),
        .testTarget(
            name: "WanaKanaTests",
            dependencies: ["WanaKana"]),
    ]
)
