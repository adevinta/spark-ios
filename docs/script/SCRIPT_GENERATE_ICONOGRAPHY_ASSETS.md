# Generate Iconography Assets Script

## Overview

This Swift script processes and organizes icon assets from a source directory into the Xcode asset catalog structure. It handles SVG files, creates imagesets, and manages the separation between Criteria and Global icons.

## Script File

`.script/generate-iconography-assets.swift`

## Usage

### Direct Execution

```bash
./.script/generate-iconography-assets.swift spark-token/iconography
```

### Using Swift Command

```bash
swift .script/generate-iconography-assets.swift spark-token/iconography
```

## Arguments

- `<source-icons-path>` (required) - Path to the directory containing SVG icon files
  - Example: `spark-token/iconography`

## Output Paths

- **Base Path**: `Resources/Sources/Core/Assets/Iconography.xcassets`
- **Criteria Icons**: `Resources/Sources/Core/Assets/Iconography.xcassets/Criteria`
- **Global Icons**: `Resources/Sources/Core/Assets/Iconography.xcassets/Global`

## Process Flow

The script executes the following steps:

### Step 1: Clear Existing Content

Removes all existing content from:
- Criteria folder
- Global folder
- Any `*.imageset` directories at the root of `Iconography.xcassets`

**Output**: Logs each removed item and confirms clearing of folders

### Step 2: Read SVG Files

Scans the source directory for SVG files.

**Validation**: Exits gracefully if no SVG files are found

### Step 3-4: Separate and Copy Icons

Icons are categorized based on naming:
- **Criteria Icons**: Files containing "Criteria" in the name
  - Copied to the Criteria folder
  - "Criteria" is removed from the filename
- **Global Icons**: All other files
  - Copied to the Global folder

**Output**: Reports count of icons copied to each category

### Step 5: Format as Imagesets

Converts each SVG file into an Xcode imageset:
1. Creates a `.imageset` directory for each icon
2. Moves the SVG file into the imageset directory
3. Generates a `Contents.json` with:
   - Vector representation preservation
   - Template rendering intent
   - Universal idiom support

### Step 6: Add Contents.json to Folders

Adds namespace configuration to all subdirectories in the asset catalog (except `.imageset` folders):

```json
{
  "properties" : {
    "provides-namespace" : true
  }
}
```

### Step 7: Clean Up Source Directory

Removes the source directory after successful processing.

**Logic**: If the path has multiple components, removes only the first component; otherwise removes the entire path.

## Helper Functions

### `removeAssetsDirectoryContents()`

Orchestrates the cleanup of existing assets:
- Clears Criteria folder contents
- Clears Global folder contents
- Removes root-level imagesets

### `removeDirectoryContents(of:name:)`

Removes all items within a specific directory.

**Parameters**:
- `path`: Directory path to clear
- `name`: Display name for logging

### `removeImagesets(from:)`

Removes all `*.imageset` directories from the specified path (typically the root of Iconography.xcassets).

**Behavior**:
- Only removes directories ending with `.imageset`
- Verifies each item is a directory before removal
- Reports number of imagesets removed

### `createDirectoryIfNeeded(at:)`

Creates a directory with intermediate directories if it doesn't exist.

### `getSVGFiles(from:)`

Returns all SVG files from the specified directory.

**Error Handling**: Throws an error if the source path doesn't exist

### `copyIcon(fileName:from:to:newName:)`

Copies an icon file from source to destination with optional renaming.

**Parameters**:
- `fileName`: Original filename
- `from`: Source directory path
- `to`: Destination directory path
- `newName`: Optional new filename (defaults to original)

### `createImageset(iconName:in:)`

Creates an Xcode imageset structure for an icon:
1. Creates `.imageset` directory
2. Moves SVG file into the directory
3. Generates `Contents.json` with proper configuration

**Configuration**:
- `preserves-vector-representation`: true
- `template-rendering-intent`: template
- Universal idiom support

### `addContentsJSONToAssetsSubfolders(in:)`

Adds or overwrites `Contents.json` files in all subdirectories (except imagesets) to enable namespace support.

## Error Handling

- Validates that source path exists before processing
- Provides clear error messages for all failures
- Exits with code 1 on errors
- Exits with code 0 if no SVG files are found (graceful)

## Output Examples

**Success Output**:
```
🚀 Starting icon management script...

Step 1: Clearing existing Global and Criteria folders...
✓ Removed [path] from Iconography.xcassets/Criteria
✓ Cleared contents of Criteria folder

✓ Removed [path] from Iconography.xcassets root
✓ Cleared contents of root folder

Step 2: Reading SVG files from source...
✓ Found 50 SVG files in spark-token/iconography

Step 3 & 4: Separating Criteria and Global icons...
✓ Copied 10 icons to Criteria folder
✓ Copied 40 icons to Global folder

Step 5: Formatting icons as imagesets...
✓ Created 10 imagesets in Criteria folder
✓ Created 40 imagesets in Global folder

Step 6: Adding Contents.json to folders in XCAssets...
✓ Added Contents.json to Criteria folder
✓ Added Contents.json to Global folder

Step 7: Cleaning up source directory...
✓ Removed source directory: spark-token

✅ Icon management completed successfully!
📁 Icons organized in:
   - Resources/Sources/Core/Assets/Iconography.xcassets/Criteria
   - Resources/Sources/Core/Assets/Iconography.xcassets/Global
```

**Error Output**:
```
❌ Error: Source path does not exist: spark-token/iconography
```

## Notes

- The script is idempotent - running it multiple times produces the same result
- All existing content is cleared before processing new icons
- SVG files are preserved as vector assets in Xcode
- Template rendering ensures icons can be tinted at runtime
- The script removes the source directory to keep the repository clean

## Related Files

- `.script/generate-iconography-codebase.swift` - Generates Swift code for the processed icons
- `Resources/Sources/Core/Assets/Iconography.xcassets` - Output asset catalog
- `.github/workflows/pr-icon-updates.yml` - Workflow that uses this script

## Dependencies

- Foundation framework (part of Swift standard library)
- No external dependencies required
