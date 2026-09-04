#!/usr/bin/env swift

/// Script to update CHANGELOG.md when a new release is published
/// Direct execution
/// ```./.script/update-changelog.swift 2.1.0 "Release notes content"```
/// Or
/// ```swift .script/update-changelog.swift 2.1.0 "Release notes content"```

import Foundation

// MARK: - Main Script

guard CommandLine.arguments.count >= 3 else {
    print("Usage: update-changelog.swift <tag-version> <release-notes>")
    print("Example: update-changelog.swift 2.1.0 \"## What's Changed\\n* Add feature\\n\\n**Full Changelog**: https://github.com/...\"")
    exit(1)
}

let tagVersion = CommandLine.arguments[1]
let releaseNotes = CommandLine.arguments[2]
let changelogPath = "CHANGELOG.md"

// MARK: - Helper Functions

private func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: Date())
}

private func cleanReleaseNotes(_ notes: String) -> String {
    var cleanedNotes = notes

    // Remove "## What's Changed" line
    cleanedNotes = cleanedNotes.replacingOccurrences(
        of: #"##\s*What'?s\s+Changed\s*\n"#,
        with: "",
        options: .regularExpression
    )

    // Remove "**Full Changelog**" line and everything after it
    if let range = cleanedNotes.range(of: #"\*\*Full Changelog\*\*.*$"#, options: .regularExpression) {
        cleanedNotes.removeSubrange(range)
    }

    // Trim leading and trailing whitespace
    return cleanedNotes.trimmingCharacters(in: .whitespacesAndNewlines)
}

private func updateChangelogContent(_ content: String, withTag tag: String, andNotes notes: String, date: String) -> String {
    var updatedContent = content

    // Step 1: Find and update the [Unreleased] link
    let unreleasedPattern = #"\[Unreleased\]:\s*https://github\.com/[^/]+/[^/]+/compare/([^.]+)\.\.\.HEAD"#
    if let regex = try? NSRegularExpression(pattern: unreleasedPattern, options: []),
       let match = regex.firstMatch(in: updatedContent, options: [], range: NSRange(updatedContent.startIndex..., in: updatedContent)) {

        let fullRange = Range(match.range, in: updatedContent)!
        let oldUnreleasedLink = String(updatedContent[fullRange])
        let newUnreleasedLink = oldUnreleasedLink.replacingOccurrences(
            of: #"/compare/[^.]+\.\.\.HEAD"#,
            with: "/compare/\(tag)...HEAD",
            options: .regularExpression
        )
        updatedContent = updatedContent.replacingOccurrences(of: oldUnreleasedLink, with: newUnreleasedLink)

        // Step 2: Extract the previous version and add the new release link
        if let previousMatch = regex.firstMatch(in: newUnreleasedLink, options: [], range: NSRange(newUnreleasedLink.startIndex..., in: newUnreleasedLink)),
           previousMatch.numberOfRanges > 1,
           let previousVersionRange = Range(previousMatch.range(at: 1), in: newUnreleasedLink) {

            let previousVersion = String(newUnreleasedLink[previousVersionRange])
            let newReleaseLink = "\n[\(tag)]: https://github.com/leboncoin/spark-ios/compare/\(previousVersion)...\(tag)"

            // Insert the new release link after the Unreleased link
            if let insertionPoint = updatedContent.range(of: newUnreleasedLink) {
                let insertionIndex = insertionPoint.upperBound
                updatedContent.insert(contentsOf: newReleaseLink, at: insertionIndex)
            }
        }
    }

    // Step 3: Create the new version section
    let cleanedNotes = cleanReleaseNotes(notes)
    let newVersionSection = """

    ## [\(tag)]

    _\(date)_

    ❗️❗️ Use the /spark-changelog skills to improve the content ❗️❗️

    \(cleanedNotes)

    """

    // Step 4: Insert the new version section after [Unreleased]
    if let unreleasedRange = updatedContent.range(of: "## [Unreleased]") {
        // Find the next line after [Unreleased]
        let searchStart = unreleasedRange.upperBound
        if let nextLineRange = updatedContent[searchStart...].range(of: "\n") {
            let insertionPoint = nextLineRange.upperBound
            updatedContent.insert(contentsOf: newVersionSection, at: insertionPoint)
        }
    }

    return updatedContent
}

// MARK: - Execution

do {
    // Read the current CHANGELOG.md
    guard FileManager.default.fileExists(atPath: changelogPath) else {
        print("❌ Error: CHANGELOG.md not found at path: \(changelogPath)")
        exit(1)
    }

    let changelogContent = try String(contentsOfFile: changelogPath, encoding: .utf8)

    // Get current date
    let currentDate = getCurrentDate()

    // Update the changelog content
    let updatedContent = updateChangelogContent(
        changelogContent,
        withTag: tagVersion,
        andNotes: releaseNotes,
        date: currentDate
    )

    // Write the updated content back to CHANGELOG.md
    try updatedContent.write(toFile: changelogPath, atomically: true, encoding: .utf8)

    print("✓ CHANGELOG.md updated successfully for version \(tagVersion)")
    print("✓ Date: \(currentDate)")
    print("✓ Please use the /spark-changelog skill to improve the content")

} catch {
    print("❌ Error: \(error.localizedDescription)")
    exit(1)
}
