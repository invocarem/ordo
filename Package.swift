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
            resources: [.process("liturgical_calendar.json")]
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
            dependencies: ["HoursService"],  
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
            resources: [.copy("../../ordo/Services/LiturgicalService/liturgical_calendar.json")]
        ),

        .testTarget(
           name: "IntegrationTests",  
           dependencies: [
            "LiturgicalService",
            "HoursService",
            "PsalmService",
            "PsalmProgressTracker"
           ],
           path: "Tests/IntegrationTests",  
           sources: ["DailyPrayerFlowTests.swift", "DailyPsalmsProgressTests.swift"],
           resources: [
                .copy("../../ordo/Services/LiturgicalService/liturgical_calendar.json"),
                .copy("../../ordo/Services/PsalmService/psalms.json")
            ]
        )



    ]
)

