# PR Icon Updates Workflow

## Overview

This GitHub Actions workflow automatically manages iconography updates by processing icon assets, generating code, and creating/updating a pull request with the changes.

## Workflow File

`.github/workflows/pr-icon-updates.yml`

## Trigger

- **Push Event**: Triggers on pushes to the `chore-updated-icons` branch

## Permissions

- `contents: write` - Write access to repository contents (for committing changes)
- `pull-requests: write` - Create and update pull requests

## Concurrency

- **Group**: `${{ github.workflow }}-${{ github.event.pull_request.head.label || github.head_ref || github.ref }}`
- **Cancel in progress**: `true` - Cancels in-progress runs when new commits are pushed

## Environment Variables

- `swift_version`: `6.2` - Swift version used for running scripts

## Jobs

### PR Icon Updates Job

**Name**: pr-icon-updates
**Runner**: macos-26

**Condition**: Only runs if the last commit message is NOT `🤖 Update iconography` (prevents recursive workflow triggers)

**Steps**:

1. **Set Swift Version** - Uses `swift-actions/setup-swift@v2.4.0` to configure Swift 6.2
2. **Get swift version** - Verifies Swift installation
3. **Checkout Action** - Checks out the `chore-updated-icons` branch with:
   - Full history (`fetch-depth: 0`)
   - Custom token (`PAT_SPARK` secret or fallback to `GITHUB_TOKEN`)
4. **Create Pull Request** - Attempts to create a PR using `gh pr create --fill`
   - Uses `continue-on-error: true` to proceed even if PR already exists
5. **Manage icons and update the pull request if needed** - Multi-step process:
   - Runs `generate-iconography-assets.swift` to process icons from `spark-token/iconography`
   - Runs `generate-iconography-codebase.swift` to generate code
   - Stages changes in `Resources/Sources/Core/Assets/Iconography.xcassets/`
   - If changes are detected:
     - Configures git with bot credentials (`spark-ui-bot`)
     - Commits with message `🤖 Update iconography`
     - Shows commit details
     - Pushes to remote
     - Outputs "UPDATED" notice
   - If no changes detected:
     - Outputs "UP-TO-DATE" notice

## Workflow Behavior

### Automatic PR Creation

When icons are pushed to the `chore-updated-icons` branch:
1. The workflow creates a PR (if it doesn't exist)
2. Processes the icons through the generation scripts
3. If changes are detected, commits and pushes them
4. The PR is automatically updated with the new commit

### Recursive Prevention

The workflow includes safeguards against infinite loops:
- Only runs if the last commit message is NOT `🤖 Update iconography`
- This prevents the workflow from triggering itself when it pushes updates

## Token Usage

The workflow uses either:
1. `PAT_SPARK` - A Personal Access Token secret (preferred)
2. `GITHUB_TOKEN` - Default GitHub Actions token (fallback)

The PAT is necessary if the workflow needs elevated permissions beyond the default token.

## Notes

- The workflow automatically manages the entire icon update process
- Changes are committed by the `spark-ui-bot` user
- The workflow is idempotent - if no changes are needed, it won't create empty commits
- The `--fill` flag in `gh pr create` uses branch name and commit messages to populate PR title and description

## Usage

To trigger this workflow:
1. Push updated icons to the `spark-token/iconography` directory
2. Push the changes to the `chore-updated-icons` branch
3. The workflow will automatically:
   - Create a PR
   - Process the icons
   - Commit and push any generated changes
   - Update the PR

## Related Files

- `.script/generate-iconography-assets.swift` - Processes and organizes icon assets
- `.script/generate-iconography-codebase.swift` - Generates Swift code for icons
- `Resources/Sources/Core/Assets/Iconography.xcassets/` - Icon asset catalog

## Bot Configuration

- **Bot Name**: spark-ui-bot
- **Bot Email**: spark-ui-bot@users.noreply.github.com
- **Commit Message Format**: `🤖 Update iconography`
