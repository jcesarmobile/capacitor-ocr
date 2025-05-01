// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "JcesarmobileCapacitorOcr",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "JcesarmobileCapacitorOcr",
            targets: ["OcrPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "OcrPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/OcrPlugin"),
        .testTarget(
            name: "OcrPluginTests",
            dependencies: ["OcrPlugin"],
            path: "ios/Tests/OcrPluginTests")
    ]
)
