import ProjectDescription

let project = Project(
    name: "SeaLens",
    packages: [
        .remote(
            url: "http://github.com/ZipArchive/ZipArchive"
            requirements: .upToNextMajor(for: "2.5.0")
        )
    ]
    targets: [
        .target(
            name: "SeaLens",
            destinations: .macOS,
            product: .app,
            bundleId: "dev.tuist.SeaLens",
            infoPlist: .default,
            buildableFolders: [
                "SeaLens/Sources",
                "SeaLens/Resources",
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
            dependencies: [.target(name: "SeaLens")]
        ),
    ]
)
