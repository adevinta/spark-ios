//
//  IconographyTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import SparkCore
import XCTest

struct IconographyTests {

    // MARK: - Shared

    static var shared = IconographyTests()

    // MARK: - Initialize

    private init() {}

    // MARK: - Icons

    lazy var arrow: UIImage = {
        return self.getImage(name: "arrow")
    }()

    lazy var checkmark: UIImage = {
        return self.getImage(name: "checkbox-selected")
    }()

    lazy var switchOff: UIImage = {
        return self.getImage(name: "switchOff")
    }()

    lazy var switchOn: UIImage = {
        return self.getImage(name: "switchOn")
    }()

    // MARK: - Helper

    private func getImage(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: Bundle(for: ClassForBundle.self), with: nil) else {
            fatalError("no image found for \(name)")
        }
        return image
    }

    private class ClassForBundle {}
}
