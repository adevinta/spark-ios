# Deploy DocC on GitHub Pages Workflow

## Overview

This GitHub Actions workflow generates and deploys DocC documentation to GitHub Pages, making the documentation publicly accessible online.

## Workflow File

`.github/workflows/deploy-docc-page.yml`

## Trigger

- **Manual Trigger**: `workflow_dispatch` - Can be manually triggered from the GitHub Actions tab

## Environment Variables

- `repo_name`: `${{ github.event.repository.name }}` - Repository name (automatically set)
- `xcodebuild_derivedData`: `.derivedData` - Path for Xcode build artifacts
- `doc_path`: `docs` - Output path for generated documentation

## Permissions

The workflow requires specific GitHub token permissions:
- `contents: read` - Read repository contents
- `pages: write` - Deploy to GitHub Pages
- `id-token: write` - Write ID tokens for deployment

## Concurrency

- **Group**: `pages` - Only one deployment can run at a time
- **Cancel in progress**: `true` - New deployments cancel ongoing ones

## Jobs

### Deploy Job

**Name**: deploy
**Runner**: macos-26
**Environment**: github-pages

**Steps**:

1. **Package names** - Logs the repository name
2. **Checkout Action** - Checks out the repository using `actions/checkout@v6`
3. **Create docs directory** - Creates the output directory for documentation
4. **Build DocC** - Executes `make docc` with:
   - `DOCC_OUTPUT_PATH=${{ env.doc_path }}` - Output directory
   - `HOSTING_BASE_PATH=${{ env.repo_name }}` - Base path for hosted documentation
5. **Setup Pages** - Configures GitHub Pages using `actions/configure-pages@v5`
6. **Upload artifact** - Uploads the documentation as an artifact using `actions/upload-pages-artifact@v3`
7. **Deploy to GitHub Pages** - Deploys the artifact to GitHub Pages using `actions/deploy-pages@v5`

**Output**:
- `page_url` - The URL where the documentation is deployed (available via `${{ steps.deployment.outputs.page_url }}`)

## Notes

- Only one deployment can run at a time due to concurrency settings
- New deployments will automatically cancel any in-progress deployments
- The documentation will be accessible at the GitHub Pages URL after successful deployment
- The workflow uses macOS runners as DocC is an Apple technology requiring Xcode

## Usage

This workflow should be manually triggered when you want to:
- Update the public documentation after significant changes
- Publish new component documentation
- Refresh the DocC documentation website

## Related Files

- `Makefile` - Contains the `docc` target for building documentation
- Documentation source files in component directories (`.docc` folders)

## GitHub Pages Setup

For this workflow to function, GitHub Pages must be configured in the repository settings:
1. Go to repository Settings > Pages
2. Set Source to "GitHub Actions"
3. The workflow will handle the deployment automatically
