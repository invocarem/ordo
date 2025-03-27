// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LiturgicalService",
    platforms: [.macOS(.v10_15)],  // Required for XCTest

    products: [
        .library(name: "LiturgicalService", targets: ["LiturgicalService"]),
        .library(name: "HoursService", targets: ["HoursService"]),
        .library(name: "PsalmService", targets: ["PsalmService"]),
        .executable(name: "LiturgicalDocker", targets: ["LiturgicalDocker"])
    ],
  
    targets: [
        .executableTarget(
            name: "LiturgicalDocker",
            dependencies: ["LiturgicalService", "HoursService", "PsalmService"],
            path: "docker-support",
            exclude: ["Dockerfile"],
            sources: ["main.swift"]
        ),
        
        .target( 
            name: "LiturgicalService",
            dependencies: [],  
            path: "ordo/Services/LiturgicalService",
            sources: ["LiturgicalService.swift", "Extensions.swift"]
        ),

        .target(
            name: "HoursService",
            dependencies: [],  
            path: "ordo/Services/HoursService",
            sources: ["HoursService.swift"],
            resources: [.process("horas.json")]
        ),

        .target(
            name: "PsalmService",
            dependencies: [],  
            path: "ordo/Services/PsalmService",  
            sources: ["PsalmService.swift"],
            resources: [.process("psalms.json")]
        ),

        .testTarget(
            name: "PsalmServiceTests",    
            dependencies: ["PsalmService"],  // Removed explicit XCTest
            path: "ordoTests/PsalmService",
            sources: ["PsalmServiceTests.swift"],
            resources: [.copy("../../ordo/Services/PsalmService/psalms.json")]
        ),

        .testTarget(  
            name: "HoursServiceTests", 
            dependencies: ["HoursService"],  // Removed explicit XCTest
            path: "ordoTests/HoursService",    
            sources: ["HoursServiceTests.swift"],
            resources: [.copy("../../ordo/Services/HoursService/horas.json")]
        ),

        .testTarget(
            name: "LiturgicalServiceTests",            
            dependencies: ["LiturgicalService"],  // Removed explicit XCTest
            path: "ordoTests/LiturgicalService",    
            sources: ["LiturgicalServiceTests.swift"]
        )
    ]
)

