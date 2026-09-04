# Update Changelog Script

## Overview

This Swift script automatically updates the CHANGELOG.md file when a new release is published. It processes release notes, updates version links, and inserts a new version section with proper formatting.

## Script File

`.script/update-changelog.swift`

## Usage

### Direct Execution

```bash
./.script/update-changelog.swift 2.1.0 "## What's Changed\n* Feature added\n\n**Full Changelog**: https://..."
```

### Using Swift Command

```bash
swift .script/update-changelog.swift 2.1.0 "Release notes content"
```

## Arguments

- `<tag-version>` (required) - The version number of the new release
  - Example: `2.1.0`, `1.0.0`, `3.2.1`
- `<release-notes>` (required) - The full release notes content from GitHub
  - Can include markdown formatting
  - Typically includes "## What's Changed" header and "**Full Changelog**" link

## Process Flow

The script executes the following steps:

### Step 1: Update [Unreleased] Link

Updates the `[Unreleased]` comparison link at the bottom of the CHANGELOG to point from the new version to HEAD.

**Before**:
```markdown
[Unreleased]: https://github.com/leboncoin/spark-ios/compare/2.0.0...HEAD
```

**After** (for version 2.1.0):
```markdown
[Unreleased]: https://github.com/leboncoin/spark-ios/compare/2.1.0...HEAD
```

### Step 2: Add New Version Link

Extracts the previous version from the updated Unreleased link and creates a new comparison link for the new release.

**Added Link**:
```markdown
[2.1.0]: https://github.com/leboncoin/spark-ios/compare/2.0.0...2.1.0
```

### Step 3: Clean Release Notes

Processes the release notes to remove unnecessary content:
- Removes `## What's Changed` header line
- Removes `**Full Changelog**` line and everything after it
- Trims leading and trailing whitespace

**Input**:
```markdown
## What's Changed
* Add TextField component
* Fix button styling

**Full Changelog**: https://github.com/leboncoin/spark-ios/compare/2.0.0...2.1.0
```

**Output**:
```markdown
* Add TextField component
* Fix button styling
```

### Step 4: Insert New Version Section

Creates and inserts a new version section immediately after the `## [Unreleased]` heading.

**New Section Format**:
```markdown
## [2.1.0]

_01/09/2026_

❗️❗️ Use the /spark-changelog skills to improve the content ❗️❗️

* Add TextField component
* Fix button styling
```

## Helper Functions

### `getCurrentDate() -> String`

Returns the current date formatted as `dd/MM/yyyy`.

**Example**: `01/09/2026`

### `cleanReleaseNotes(_ notes: String) -> String`

Cleans the raw release notes by:
1. Removing the "What's Changed" header using regex
2. Removing the "Full Changelog" line and everything after it
3. Trimming whitespace

**Parameters**:
- `notes`: Raw release notes from GitHub

**Returns**: Cleaned release notes ready for insertion

### `updateChangelogContent(_:withTag:andNotes:date:) -> String`

Performs the complete CHANGELOG update process.

**Parameters**:
- `content`: Current CHANGELOG.md content
- `tag`: New version tag (e.g., "2.1.0")
- `notes`: Release notes to insert
- `date`: Current date string

**Returns**: Updated CHANGELOG.md content

**Process**:
1. Finds and updates the Unreleased link
2. Extracts the previous version
3. Adds the new version link
4. Cleans the release notes
5. Creates the new version section
6. Inserts the section after [Unreleased]

## Error Handling

- Validates that CHANGELOG.md exists at the expected path
- Provides clear error messages for file system errors
- Exits with code 1 on errors
- Reports successful completion with version details

## Output Examples

**Success Output**:
```
✓ CHANGELOG.md updated successfully for version 2.1.0
✓ Date: 01/09/2026
✓ Please use the /spark-changelog skill to improve the content
```

**Error Output**:
```
❌ Error: CHANGELOG.md not found at path: CHANGELOG.md
```

## Example Transformation

### Before Update

```markdown
# Changelog

## [Unreleased]

## [2.0.0]

_03/12/2026_

### Features

- New button component

<!-- Links -->

[Unreleased]: https://github.com/leboncoin/spark-ios/compare/2.0.0...HEAD

[2.0.0]: https://github.com/leboncoin/spark-ios/compare/1.0.0...2.0.0
```

### After Update (version 2.1.0)

```markdown
# Changelog

## [Unreleased]

## [2.1.0]

_01/09/2026_

❗️❗️ Use the /spark-changelog skills to improve the content ❗️❗️

* Add TextField component
* Fix button styling

## [2.0.0]

_03/12/2026_

### Features

- New button component

<!-- Links -->

[Unreleased]: https://github.com/leboncoin/spark-ios/compare/2.1.0...HEAD

[2.1.0]: https://github.com/leboncoin/spark-ios/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/leboncoin/spark-ios/compare/1.0.0...2.0.0
```

## Notes

- The script is designed to be run by the release workflow automatically
- It uses the current system date for the release date
- The reminder to use `/spark-changelog` skill is always included
- Release notes are automatically cleaned of GitHub's standard headers
- The script preserves all existing CHANGELOG content
- Version links follow the GitHub compare URL format

## Related Files

- `.github/workflows/release-changelog-update.yml` - Workflow that triggers this script
- `CHANGELOG.md` - The file being updated
- `docs/WORKFLOW_RELEASE_CHANGELOG_UPDATE.md` - Workflow documentation

## Dependencies

- Foundation framework (part of Swift standard library)
- No external dependencies required

## Regular Expressions Used

### Remove "What's Changed" Header

```regex
##\s*What'?s\s+Changed\s*\n
```

Matches variations like:
- `## What's Changed\n`
- `##What's Changed\n`
- `## Whats Changed\n`

### Remove "Full Changelog" Line

```regex
\*\*Full Changelog\*\*.*$
```

Matches from "**Full Changelog**" to the end of the string.

### Extract Unreleased Link

```regex
\[Unreleased\]:\s*https://github\.com/[^/]+/[^/]+/compare/([^.]+)\.\.\.HEAD
```

Captures the previous version number from the Unreleased comparison link.
