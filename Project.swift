import ProjectDescription

let project = Project(
    name: "SeaLens",
    packages: [
        .remote(
            url: 
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
