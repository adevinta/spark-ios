#!/bin/bash

#Go to home
cd ..

# Generate xcodeproj
rm -rf ./*.xcodeproj # Keep a single .xcodeproj
xcodegen
