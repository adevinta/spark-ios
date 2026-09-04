# Release Changelog Update Workflow

## Overview

This GitHub Actions workflow automatically updates the CHANGELOG.md file when a new release is published. It creates a pull request with the updated changelog, including the release notes and proper version links.

## Workflow File

`.github/workflows/release-changelog-update.yml`

## Trigger

- **Release Event**: Triggers when a release is published (`types: [published]`)

## Permissions

- `contents: write` - Write access to repository contents (for committing changes)
- `pull-requests: write` - Create pull requests

## Environment Variables

- `swift_version`: `6.2` - Swift version used for running scripts

## Jobs

### Update Changelog Job

**Name**: update-changelog
**Runner**: macos-26

**Steps**:

1. **Set Swift Version** - Uses `swift-actions/setup-swift@v2.4.0` to configure Swift 6.2
2. **Get swift version** - Verifies Swift installation
3. **Checkout repository** - Checks out the repository with:
   - Full history (`fetch-depth: 0`)
   - Custom token (`PAT_SPARK` secret or fallback to `GITHUB_TOKEN`)
4. **Create branch for changelog update** - Creates a new branch named `chore/update-changelog-{version}`
   - Configures git with bot credentials (`spark-ui-bot`)
   - Stores the branch name in the environment
5. **Update CHANGELOG.md** - Runs the `update-changelog.swift` script with:
   - Tag version from the release
   - Release body/notes from the release
6. **Commit and push changes** - If changes are detected:
   - Stages the CHANGELOG.md file
   - Commits with message `chore(changelog) 📝 Update CHANGELOG.md for release {version}`
   - Pushes to the newly created branch
   - Outputs "CHANGELOG updated" notice
7. **Create Pull Request** - Creates a PR with:
   - Title: `chore(changelog): Update CHANGELOG.md for release {version}`
   - Body: Description with link to the release and reminder to use `/spark-changelog` skill
   - Base branch: `main`
   - Head branch: The newly created branch

## Workflow Behavior

### Automatic CHANGELOG Update

When a new release is published on GitHub:
1. The workflow creates a dedicated branch for the changelog update
2. Runs the update script to process the release notes
3. Commits the changes
4. Creates a pull request for review

### CHANGELOG Modifications

The `update-changelog.swift` script performs the following operations:
1. Updates the `[Unreleased]` link to point to the new version
2. Adds a new version link in the links section
3. Inserts a new version section after `[Unreleased]` with:
   - Version number as heading
   - Current date
   - Reminder to use `/spark-changelog` skill
   - Cleaned release notes (removes "What's Changed" header and "Full Changelog" link)

## Token Usage

The workflow uses either:
1. `PAT_SPARK` - A Personal Access Token secret (preferred)
2. `GITHUB_TOKEN` - Default GitHub Actions token (fallback)

The PAT is necessary for creating pull requests that can trigger other workflows.

## Notes

- The workflow only triggers on published releases (not drafts or pre-releases)
- A new branch is created for each release to keep changes isolated
- The PR description reminds reviewers to use the `/spark-changelog` skill to improve formatting
- If no changes are detected (e.g., CHANGELOG already updated), the workflow exits gracefully

## Usage

To trigger this workflow:
1. Create a new release on GitHub
2. Publish the release
3. The workflow will automatically:
   - Create a branch
   - Update CHANGELOG.md
   - Create a PR for review

After the workflow completes:
1. Review the generated PR
2. Use the `/spark-changelog` skill to improve the content formatting
3. Merge the PR once satisfied with the changelog

## Related Files

- `.script/update-changelog.swift` - Script that updates the CHANGELOG.md file
- `CHANGELOG.md` - The changelog file being updated

## Bot Configuration

- **Bot Name**: spark-ui-bot
- **Bot Email**: spark-ui-bot@users.noreply.github.com
- **Branch Name Format**: `chore/update-changelog-{version}`
- **Commit Message Format**: `chore(changelog) 📝 Update CHANGELOG.md for release {version}`
- **PR Title Format**: `chore(changelog): Update CHANGELOG.md for release {version}`

## Example

When releasing version `2.1.0`:

**Branch Created**: `chore/update-changelog-2.1.0`

**Commit Message**: `chore(changelog) 📝 Update CHANGELOG.md for release 2.1.0`

**PR Title**: `chore(changelog): Update CHANGELOG.md for release 2.1.0`

**CHANGELOG.md Changes**:
- `[Unreleased]` link updated to compare from `2.1.0...HEAD`
- New link added: `[2.1.0]: https://github.com/leboncoin/spark-ios/compare/2.0.0...2.1.0`
- New section added with release notes under `## [2.1.0]`
