import ProjectDescription

let project = Project(
    name: "SeaLens",
    targets: [
        .target(
            name: "SeaLens",
            destinations: .macOS,
            product: .app,
            bundleId: "dev.tuist.SeaLens",
            infoPlist: .default,
            sources: ["SeaLens/sources/**],
            resources: ["Sealens/resources/**"],
            dependencies: [
                .external(name: ZipArchive")
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
