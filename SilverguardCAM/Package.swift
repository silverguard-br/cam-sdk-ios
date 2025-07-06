// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "SilverguardCAM",
    defaultLocalization: "pt", // Opcional, define a linguagem padrão dos recursos
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SilverguardCAM",
            targets: ["SilverguardCAM"]
        )
    ],
    targets: [
        .target(
            name: "SilverguardCAM",
            path: "SilverguardCAM/Sources/SilverguardCAM",
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .define("SWIFT_PACKAGE")
            ]
        )
    ]
)
