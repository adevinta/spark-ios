#!/bin/bash

# This script is invoked by xcodegen after the project has been generated.

WORKSPACE_FILE=$(find . -maxdepth 1 -name "*.xcodeproj")
WORKSPACE_SHARED_DATA_FOLDER=$WORKSPACE_FILE/xcshareddata/

# Create workspace shared data folder if it does not exist
mkdir -p $WORKSPACE_SHARED_DATA_FOLDER

# Move file header template in workspace shared data folder
cp -rf IDETemplateMacros.plist $WORKSPACE_SHARED_DATA_FOLDER
