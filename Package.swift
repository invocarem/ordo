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
            dependencies: ["LiturgicalService", "HoursService"],
            path: "docker-support",
            sources:["main.swift"]
        ),

        
        .target( 
            name: "LiturgicalService",
            dependencies: ["PsalmService"],  
            path: "ordo",
            sources:["LiturgicalService.swift", "Extensions.swift"]
        ),

        .target(
            name: "HoursService",
            path: "ordo",
            sources:["HoursService.swift"],
            resources: [  
                .process("horas.json")
            ]
        ),

        .target(
            name: "PsalmService",
            path: "ordo",
            sources:["PsalmService.swift"],
            resources: [  
                .process("psalms.json")
            ]
        ),

        .testTarget(  // TDD
            name: "PsalmServiceTests", 
            dependencies: [
                "PsalmService",
                  .product(name: "Testing", package: "swift-testing")  // 👈 New
            ],           
            path: "ordoTests",    
            sources: ["PsalmServiceTests.swift"],
            resources: [  
               .copy("../ordo/psalms.json")  // For test target
            ]
            
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
