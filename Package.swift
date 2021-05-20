// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "DGActivityIndicatorView",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "DGActivityIndicatorView",
            targets: ["DGActivityIndicatorView"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DGActivityIndicatorView",
            path: "DGActivityIndicatorView",
            publicHeadersPath: ""
        ),
    ]
)
