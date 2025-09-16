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
        .executable(name: "LiturgicalDocker", targets: ["LiturgicalDocker"]),
    ],

    targets: [
        .executableTarget(
            name: "LiturgicalDocker",
            dependencies: [
                "LiturgicalService", "HoursService", "PsalmService", "PsalmProgressTracker",
            ],
            path: "docker-support",
            exclude: ["Dockerfile", "Dockerfile.test"],
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
        .target(
            name: "LatinService",
            dependencies: [],
            path: "ordo/Services/LatinService",
            sources: [
                "LatinService.swift",
                "LatinWordEntity.swift",
                "LatinWordAnalysis.swift",
                "LatinThematicAnalysis.swift",
                "LatinWordVerbForms.swift",
                "LemmaMapping.swift",
            ],
            resources: [
                .process("words.json"), .process("translations.json"), .process("themes.json"),
            ]
        ),
        .testTarget(
            name: "PsalmServiceTests",
            dependencies: ["PsalmService"],
            path: "Tests/PsalmService",
            sources: ["PsalmServiceTests.swift"],
            resources: [.copy("../../ordo/Services/PsalmService/psalms.json")]
        ),

        .testTarget(
            name: "LatinServiceTests",
            dependencies: ["LatinService"],
            path: "Tests/LatinService",
            sources: [
                "Utilities/PsalmTestUtilities.swift",
                "LatinWordTests.swift",
                "Psalm1Tests.swift",
                "Psalm2Tests.swift",
                "Psalm3Tests.swift",
                "Psalm4Tests.swift",
                "Psalm5Tests.swift",
                "Psalm6Tests.swift",
                "Psalm7Tests.swift",
                "Psalm8Tests.swift",
                "Psalm9Tests.swift",
                "Psalm10Tests.swift",
                "Psalm11Tests.swift",
                "Psalm12Tests.swift",
                "Psalm13Tests.swift",
                "Psalm14Tests.swift",
                "Psalm15Tests.swift",
                "Psalm16Tests.swift",

                "Psalm17ATests.swift",
                "Psalm17BTests.swift",
                "Psalm18Tests.swift",
                "Psalm19Tests.swift",
                "Psalm20Tests.swift",
                "Psalm21Tests.swift",

                "Psalm22Tests.swift",

                "Psalm34Tests.swift",

                "Psalm47Tests.swift",

                "Psalm50Tests.swift",

                "Psalm56Tests.swift",

                "Psalm62Tests.swift",
                "Psalm63Tests.swift",
                "Psalm64Tests.swift",

                "Psalm66Tests.swift",

                "Psalm75Tests.swift",

                "Psalm78Tests.swift",

                "Psalm87Tests.swift",

                "Psalm89Tests.swift",
                "Psalm90Tests.swift",
                "Psalm91Tests.swift",

                "Psalm94Tests.swift",

                "Psalm101Tests.swift",
                "Psalm102Tests.swift",

                "Psalm109Tests.swift",

                "Psalm113Tests.swift",

                "118/Psalm118Tests.swift",
                "118/Psalm118AlephTests.swift",
                "118/Psalm118BethTests.swift",
                "118/Psalm118GimelTests.swift",
                "118/Psalm118DalethTests.swift",

                "118/Psalm118HeTests.swift",
                "118/Psalm118VauTests.swift",
                "118/Psalm118ZainTests.swift",

                "118/Psalm118NunTests.swift",
                "118/Psalm118SamechTests.swift",
                "118/Psalm118AinTests.swift",

                "118/Psalm118CaphTests.swift",
                "118/Psalm118LamedTests.swift",
                "118/Psalm118MemTests.swift",

                "118/Psalm118PeTests.swift",
                "118/Psalm118SadeTests.swift",
                "118/Psalm118CophTests.swift",
                "118/Psalm118ResTests.swift",
                "Psalm119Tests.swift",
                "Psalm120Tests.swift",
                "Psalm121Tests.swift",
                "Psalm122Tests.swift",
                "Psalm123Tests.swift",
                "Psalm124Tests.swift",

                "Psalm125Tests.swift",
                "Psalm126Tests.swift",
                "Psalm127Tests.swift",
                "Psalm128Tests.swift",

                "Psalm129Tests.swift",
                "Psalm130Tests.swift",
                "Psalm131Tests.swift",
                "Psalm132Tests.swift",

                "Psalm133Tests.swift",

                "Psalm136Tests.swift",
                "Psalm138Tests.swift",

                "Psalm141Tests.swift",
                "Psalm142Tests.swift",
                "Psalm144Tests.swift",

                "Psalm148Tests.swift",
                "Psalm149Tests.swift",
                "Psalm150Tests.swift",

                "PsalmDegreesTests.swift",
                "Psalm36ATests.swift",
                "Psalm36BTests.swift",
            ],
            resources: [
                .copy("../../ordo/Services/LatinService/words.json"),
                .copy("../../ordo/Services/LatinService/translations.json"),
                .copy("../../ordo/Services/LatinService/themes.json"),
            ]
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
                "PsalmProgressTracker",
            ],
            path: "Tests/IntegrationTests",
            sources: ["DailyPrayerFlowTests.swift", "DailyPsalmsProgressTests.swift"],
            resources: [
                .copy("../../ordo/Services/LiturgicalService/liturgical_calendar.json"),
                .copy("../../ordo/Services/PsalmService/psalms.json"),
            ]
        ),

    ]
)
