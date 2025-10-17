// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "SeaLens",
    dependencies: [
        // Add your external Swift package dependencies here
        .package(url: "https://github.com/ZipArchive/ZipArchive.git", from: "2.6.0")
    ]
)
