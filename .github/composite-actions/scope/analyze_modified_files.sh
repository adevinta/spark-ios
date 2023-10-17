#!/bin/bash

# Get modified files list from command-line arguments
MODIFIED_FILES="$@"

# echo "Simulated modified files:"
# echo "$MODIFIED_FILES"

# Extract modified component scopes
COMPONENT_SCOPES=$(echo "$MODIFIED_FILES" | sed -n 's#.*Components/\([^/]*\)/.*#\1#p' | sort -u)

# echo "Modified component scopes:"
# echo "$COMPONENT_SCOPES"

# Initialize lists for test classes
SWIFTUI_TESTS=""
UIKIT_TESTS=""

# Analyze subfolders under View folder and add test classes to respective lists
for COMPONENT in $COMPONENT_SCOPES; do
    if grep -q "core/Sources/Components/$COMPONENT/View/SwiftUI/" <<< "$MODIFIED_FILES"; then
        SWIFTUI_TESTS="$SWIFTUI_TESTS ${COMPONENT}ViewSnapshotTests"
    fi

    if grep -q "core/Sources/Components/$COMPONENT/View/UIKit/" <<< "$MODIFIED_FILES"; then
        UIKIT_TESTS="$UIKIT_TESTS ${COMPONENT}UIViewSnapshotTests"
    fi
done

# Print the lists of test classes
# echo "SwiftUI Test Classes: $SWIFTUI_TESTS"
# echo "UIKit Test Classes: $UIKIT_TESTS"

# Combine SwiftUI and UIKit test classes into a single list
ALL_TESTS="$SWIFTUI_TESTS $UIKIT_TESTS"

# Print the combined list of test classes
echo "$ALL_TESTS"