// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LiturgicalService",
    platforms: [.macOS(.v10_15)],  // Required for XCTest
    
    products: [
        .library(name: "LiturgicalService", targets: ["LiturgicalService"]),
        .library(name: "HoursService", targets: ["HoursService"]),
        .library(name: "PsalmService", targets: ["PsalmService"]),
         .library(name: "PsalmProgressTracker", targets: ["PsalmProgressTracker"]),
        .executable(name: "LiturgicalDocker", targets: ["LiturgicalDocker"])
    ],
   
    targets: [
        .executableTarget(
            name: "LiturgicalDocker",
            dependencies: ["LiturgicalService", "HoursService", "PsalmService" ,"PsalmProgressTracker" ],
            path: "docker-support",
            exclude: ["Dockerfile"],
            sources: ["main.swift"]
        ),
        
        .target( 
            name: "LiturgicalService",
            dependencies: [],  
            path: "ordo/Services/LiturgicalService",
            sources: ["LiturgicalService.swift", "Extensions.swift"],
            resources: [.process("office.json")]
        ),

        .target(
            name: "HoursService",
            dependencies: [],  
            path: "ordo/Services/HoursService",
            sources: ["HoursService.swift"],
            resources: [.process("horas.json")]
        ),
         .target(
            name: "PsalmProgressTracker",
            dependencies: [],
            path: "ordo/PsalmProgressTracker",
            sources: ["PsalmProgressTracker.swift"]
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
            dependencies: ["PsalmService"],
            path: "Tests/PsalmService",
            sources: ["PsalmServiceTests.swift"],
            resources: [.copy("../../ordo/Services/PsalmService/psalms.json")]
        ),

        .testTarget(  
            name: "HoursServiceTests", 
            dependencies: ["HoursService"],  // Removed explicit XCTest
            path: "Tests/HoursService",    
            sources: ["HoursServiceTests.swift"],
            resources: [.copy("../../ordo/Services/HoursService/horas.json")]
        ),

         .testTarget(
            name: "PsalmProgressTrackerTests",
            dependencies: ["PsalmProgressTracker", "PsalmService"],
            path: "Tests/PsalmProgressTracker",
            
            sources: ["PsalmProgressTrackerTests.swift"],
            resources: [.copy("../../ordo/Services/PsalmService/psalms.json")]
        ),

        .testTarget(
            name: "LiturgicalServiceTests",            
            dependencies: ["LiturgicalService"],
            path: "Tests/LiturgicalService",    
            sources: ["LiturgicalServiceTests.swift"],
            resources: [.copy("../../ordo/Services/LiturgicalService/office.json")]
        )
    ]
)

