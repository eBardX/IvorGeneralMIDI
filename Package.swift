// swift-tools-version: 6.3

// © 2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

let package = Package(name: "IvorGeneralMIDI",
                      platforms: [.iOS(.v18),
                                  .macOS(.v15)],
                      products: [.library(name: "IvorGeneralMIDI",
                                          targets: ["IvorGeneralMIDI"])],
                      dependencies: [.package(url: "https://github.com/eBardX/IvorMIDI.git",
                                              .upToNextMinor(from: "0.3.0")),
                                     .package(url: "https://github.com/eBardX/XestiTools.git",
                                              .upToNextMajor(from: "10.0.0"))],
                      targets: [.target(name: "IvorGeneralMIDI",
                                        dependencies: [.product(name: "IvorMIDI",
                                                                package: "IvorMIDI"),
                                                       .product(name: "XestiTools",
                                                                package: "XestiTools")],
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "IvorGeneralMIDITests",
                                            dependencies: [.target(name: "IvorGeneralMIDI"),
                                                           .product(name: "IvorMIDI",
                                                                    package: "IvorMIDI"),
                                                           .product(name: "XestiTools",
                                                                    package: "XestiTools")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageModes: [.v6])
