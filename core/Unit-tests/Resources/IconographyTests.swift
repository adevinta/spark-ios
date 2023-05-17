//
//  IconographyTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Spark
import SwiftUI
import SparkCore
import XCTest

struct IconographyTests {
    // MARK: - Shared

    static var shared = IconographyTests()

    // MARK: - Initialize

    private init() {}

    // MARK: - Icons

    lazy var checkmark: UIImage = {
        return getImage(name: "checkbox-selected")
    }()

    // MARK: - Helper

    private func getImage(name: String) -> UIImage {
        guard let image =  UIImage(named: name, in: Bundle(for: ClassForBundle.self), with: nil) else {
            fatalError("no image found for \(name)")
        }
        return image
    }

    private class ClassForBundle {}
}

