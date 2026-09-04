# Spark iOS Design System

<p align="center">
<picture>
    <source media="(prefers-color-scheme: dark)" srcset=".art/spark-logo-dark.svg">
    <img alt="Spark Design System logo" src=".art/spark-logo-light.svg">
  </picture>
</p>

**Spark** is the [Leboncoin](https://www.leboncoin.fr/)'s _Design System_.

// TODO: improve

## 🚀 Getting Started

_Note: Instructions below are for using **SPM** without the Xcode UI. It's the easiest to go to your Project Settings -> Swift Packages and add SparkComponentButton from there._

To integrate using Apple's Swift package manager, without Xcode integration, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/leboncoin/spark-ios.git", .upToNextMajor(from: "2.0.0"))
```

and then specify `Spark` as a dependency of the Target in which you wish to use the SparkComponentButton.

Here's an example `Package.swift`:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MyPackage",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/leboncoin/spark-ios.git",
            .upToNextMajor(from: "1.0.0")
        )
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: [
                .product(
                    name: "Spark",
                    package: "spark-ios"
                ),
            ]
        )
    ]
)
```

## Documentation

### DocC

Technical *API* documentation in _DocC_ format is available on our dedicated [website](https://leboncoin.github.io/spark-ios/).

### Makefile

Build, test, and development commands are documented in the [Makefile documentation](docs/MAKEFILE.md).

### GitHub Actions

[Workflows Documentation](docs/WORKFLOWS.md) - Continuous integration and deployment workflows

### Scripts

[Scripts Documentation](docs/SCRIPTS.md) - Utility scripts for code generation and asset management

### Configurations

[Spark Tokens Bridge Setup](docs/SPARK_TOKENS_BRIDGE_SETUP.md) - Setup and configuration for the Spark tokens bridge

### Claude Skills

[Claude Skills Documentation](docs/CLAUDE_SKILLS.md) - Comprehensive guide to all available Claude Code skills for component development


## Contributing

Please take a look at the [contribution guide](docs/CONTRIBUTING.md) to setup your dev environment and get a list of common tasks used in this project, as well as the [Code of conduct](docs/CODE_OF_CONDUCT.md).

## License

    Copyright (c) 2023 Adevinta
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
