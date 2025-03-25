// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "LiturgicalService",
 

    products: [
        .library(
            name: "LiturgicalService",
            targets: ["LiturgicalService"]),
        .executable(
            name: "LiturgicalDocker",
            targets: ["LiturgicalDocker"])
    ],
    dependencies: [
                .package(url: "https://github.com/apple/swift-testing.git", from: "0.8.0")
    ],
    targets: [
        .executableTarget(
            name: "LiturgicalDocker",
            dependencies: ["LiturgicalService"],
            path: "docker-support",
            sources:["main.swift"]
        ),

        
        .target( // Library target (for xcode
            name: "LiturgicalService",
            path: "ordo",
            sources:["LiturgicalService.swift", "Extensions.swift"]
        ),

        
        .testTarget(  // TDD
            name: "LiturgicalServiceTests",            
            dependencies: [
                "LiturgicalService",
                .product(name: "Testing", package: "swift-testing")  // 👈 New
            ],
            path: "ordoTests",    
            exclude: ["ordoTests.swift"],        
            sources: ["LiturgicalServiceTests.swift"]
            
        )

    ]
)
