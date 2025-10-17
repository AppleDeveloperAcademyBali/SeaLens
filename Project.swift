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
            buildableFolders: [
                "SeaLens/App",
                "SeaLens/Features",
                "SeaLens/Shared",
                "SeaLens/Resources",
            ],
            dependencies: []
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
