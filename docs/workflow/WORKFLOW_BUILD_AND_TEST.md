# Build and Test Workflow

## Overview

This GitHub Actions workflow performs continuous integration tasks including building the project and running unit and snapshot tests.

## Workflow File

`.github/workflows/build-and-test.yml`

## Trigger

- **Manual Trigger**: `workflow_dispatch` - Can be manually triggered from the GitHub Actions tab

## Environment Variables

- `swift_version`: `6.2` - Swift version used for all jobs
- `xcode_path`: `/Applications/Xcode_26.3.app` - Xcode installation path

## Jobs

### 1. Build Job

**Name**: Build
**Runner**: macos-26

**Steps**:
1. **Package name** - Logs the workspace path
2. **Set Swift Version** - Uses `swift-actions/setup-swift@v2.4.0` to configure Swift 6.2
3. **Get swift version** - Verifies Swift installation
4. **Select Xcode** - Configures Xcode 26.3
5. **Checkout Action** - Checks out the repository using `actions/checkout@v6`
6. **Build** - Executes `make build` to build all packages

### 2. Unit Test Job

**Name**: Unit Test
**Runner**: macos-26

**Steps**:
1. **Package name** - Logs the workspace path
2. **Set Swift Version** - Uses `swift-actions/setup-swift@v2.4.0` to configure Swift 6.2
3. **Get swift version** - Verifies Swift installation
4. **Select Xcode** - Configures Xcode 26.3
5. **Checkout Action** - Checks out the repository using `actions/checkout@v6`
6. **Test** - Executes `make test-unit` with a 15-minute timeout

### 3. Snapshot Test Job

**Name**: Snapshot Test
**Runner**: macos-26

**Steps**:
1. **Package name** - Logs the workspace path
2. **Set Swift Version** - Uses `swift-actions/setup-swift@v2.4.0` to configure Swift 6.2
3. **Get swift version** - Verifies Swift installation
4. **Select Xcode** - Configures Xcode 26.3
5. **Checkout Action** - Checks out the repository using `actions/checkout@v6`
6. **Test** - Executes `make test-snapshots` with a 15-minute timeout

## Notes

- All jobs run in parallel on macOS 26 runners
- Each job independently sets up Swift and Xcode
- Test jobs have a 15-minute timeout to prevent hanging
- Runner information is available at:
  - General: https://github.com/actions/runner-images
  - macOS-specific: https://github.com/actions/runner-images/tree/main/images/macos

## Usage

This workflow can be manually triggered from the GitHub Actions tab when you need to verify that:
- All packages build successfully
- All unit tests pass
- All snapshot tests pass

## Related Files

- `Makefile` - Contains the `build`, `test-unit`, and `test-snapshots` targets
