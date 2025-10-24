import ProjectDescription

let project = Project(
    name: "SeaLens",
    packages: [
        .remote(
            url: "https://github.com/ZipArchive/ZipArchive.git",
            requirement: .upToNextMajor(from: "2.5.0")
        )
    ],
    targets: [
        .target(
            name: "SeaLens",
            destinations: .macOS,
            product: .app,
            bundleId: "dev.tuist.SeaLens",
            infoPlist: .default,
            buildableFolders: [
                "SeaLens/App",
                "SeaLens/Features",
                "SeaLens/Resources",
                "SeaLens/Shared",
            ],
            dependencies: [
                .package(product: "ZipArchive")
            ]
        ),
        .target(
            name: "SeaLensTests",
            destinations: .macOS,
            product: .unitTests,
            bundleId: "dev.tuist.SeaLensTests",
            infoPlist: .default,
            buildableFolders: [
                "SeaLens/Tests"
            ],
            dependencies: [
                .target(name: "SeaLens")
            ]
        )
    ]
)
