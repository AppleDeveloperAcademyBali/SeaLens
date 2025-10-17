import ProjectDescription

let project = Project(
    name: "SeaLens",
    targets: [
        // MARK: - Main App Target
        .target(
            name: "SeaLens",
            destinations: .macOS,
            product: .app,
            bundleId: "dev.tuist.SeaLens",
            infoPlist: .default,
            buildableFolders: [
                "SeaLens/App",
                "SeaLens/Resources"
            ],
            dependencies: [
                .external(name: "ZipArchive")
            ]
        ),

        

        // MARK: - Tests Target
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
