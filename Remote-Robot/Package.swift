import PackageDescription

let package = Package(
    name: "Remote-Robot",
    targets: [
      Target(name: "Application", dependencies: [ .Target(name: "Generated") ]),
      Target(name: "Remote-Robot", dependencies: [ .Target(name: "Application") ])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git",             majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git",       majorVersion: 1, minor: 7),
        .Package(url: "https://github.com/IBM-Swift/CloudConfiguration.git", majorVersion: 2),
        .Package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", majorVersion: 1),
        .Package(url: "https://github.com/IBM-Swift/Aphid.git", majorVersion: 0)
        

    ],
    exclude: ["src"]
)
