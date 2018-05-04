// swift-tools-version:4.0
import PackageDescription
let package = Package(
    name: "leaky-kitura",
    products: [
        .executable(name: "leaky-kitura", targets: ["leaky-kitura"])
        ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", from: "17.0.0"),
    ],
    targets: [
        .target(name: "leaky-kitura", dependencies: ["HeliumLogger", "Kitura", "CredentialsHTTP", "SwiftyJSON"]),
    ]
)
