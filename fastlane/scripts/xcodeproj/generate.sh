#!/bin/bash

ROOT_FOLDER=$1
TEMPLATE_FILE=$2

#Go to home
cd ..

#Go to root folder
cd $ROOT_FOLDER

# Generate xcodeproj
rm -rf ./*.xcodeproj # Keep a single .xcodeproj

if [[ -z "$TEMPLATE_FILE" ]]
then
    xcodegen
else
    xcodegen --spec $TEMPLATE_FILE
fi
    
