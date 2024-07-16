#!/usr/bin/swift

/**
 This script is launched when you add a /buildDemo comment of the spark-ios-component-XYZ repository pull requests .

 The goal of the script is to replace the external component package (spark-ios-component-XYZ repository) to the local (from ../ folder).
 */

// swiftlint:disable all

import Foundation

if CommandLine.argc < 2 {
    fatalError("No arguments are passed...")
} else {
    let package = CommandLine.arguments.last!
    print(package)

    let url = URL(filePath: "../Package.swift")
    let dependencyContent = getDependencyContent(url, package: package)
    changeToLocalPackage(url, package: package, dependency: dependencyContent)
}

func getDependencyContent(_ url: URL, package: String) -> String {
    do {
        let text = try String(
            contentsOf: url,
            encoding: .utf8
        )

        var dependency: String!
        if let dependencies = text.sliceMultipleTimes(from: "dependencies", to: "]").first {
            dependencies.sliceMultipleTimes(from: ".package(", to: ")").forEach {

                print("Packages \($0)")

                if let name = $0.sliceMultipleTimes(from: "path: \"../", to: "\"").first,
                   package == name {
                    dependency = $0
                }
            }
        } else {
            fatalError("No dependencies found...")
        }

        return dependency
    } catch {
        fatalError("Files can't be read...")
    }
}

func changeToLocalPackage(_ url: URL, package: String, dependency: String) {
    do {
        var text = try String(
            contentsOf: url,
            encoding: .utf8
        )

        let newContent = dependency
            .replacingOccurrences(
                of: "// path",
                with: "path"
            )
            .replacingOccurrences(
                of: "url",
                with: "// url"
            )
            .replacingOccurrences(
                of: "/*version*/ ",
                with: "// /*version*/ "
            )
            .replacingOccurrences(
                of: "../\(package)",
                with: "../"
            )

        text = text.replacingOccurrences(
            of: dependency,
            with: newContent
        )

        try text.write(
            to: url,
            atomically: false,
            encoding: .utf8
        )

        print("Package.swift is updated")

    } catch {
        fatalError("Files can't be read...")
    }
}

// MARK: - Extension

extension String {

    func sliceMultipleTimes(from: String, to: String) -> [String] {
        self.components(separatedBy: from).dropFirst().compactMap { sub in
            (sub.range(of: to)?.lowerBound).flatMap { endRange in
                String(sub[sub.startIndex ..< endRange])
            }
        }
    }
}
