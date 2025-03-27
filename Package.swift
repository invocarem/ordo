// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "LiturgicalService",
 

    products: [
        .library(
            name: "LiturgicalService",
            targets: ["LiturgicalService"]),
        .library(
            name: "HoursService",
            targets: ["HoursService"]),
        .library(
            name: "PsalmService",
            targets: ["PsalmService"]),

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
            dependencies: ["LiturgicalService", "HoursService", "PsalmService"],
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
            path: "ordoTests/PsalmService",    
            sources: ["PsalmServiceTests.swift"],
            resources: [  
               .copy("../ordo/psalms.json")  // For test target
            ]
            
        ),
         .testTarget(  
            name: "HoursServiceTests", 
            dependencies: [
                "HoursService",
                  .product(name: "Testing", package: "swift-testing")  // 👈 New
            ],           
            path: "ordoTests/HoursService",    
            
            sources: ["HoursServiceTests.swift"],
            
            resources: [  
               .copy("../ordo/horas.json")  // For test target
            ]
            
        ),

        .testTarget(  // TDD
            name: "LiturgicalServiceTests",            
            dependencies: [
                "LiturgicalService",
                .product(name: "Testing", package: "swift-testing")  // 👈 New
            ],
            path: "ordoTests/LiturgicalService",    
            exclude: ["ordoTests.swift"],        
            sources: ["LiturgicalServiceTests.swift"]
            
        )

    ]
)
