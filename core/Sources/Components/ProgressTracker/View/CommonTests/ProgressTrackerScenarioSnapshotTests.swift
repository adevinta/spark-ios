//
//  ProgressTrackerScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 12.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

@testable import SparkCore

enum ProgressTrackerContentType {
    case icon
    case text
    case empty
}

enum ProgressTrackerScenarioSnapshotTests: String, CaseIterable {
    case test1 // all intents
//    case test2
//    case test3
//    case test4
//    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1(isSwiftUIComponent: isSwiftUIComponent)
//        case .test2:
//            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
//        case .test3:
//            return self.test3(isSwiftUIComponent: isSwiftUIComponent)
//        case .test4:
//            return self.test4(isSwiftUIComponent: isSwiftUIComponent)
//        case .test5:
//            return self.test5(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intents: all
    ///  - variant: outlined
    ///  - state: enabled
    ///  - content: icon
    ///  - size: medium
    ///  - orientation: horizontal
    ///  - mode: all
    private func test1(isSwiftUIComponent: Bool) -> [ProgressTrackerConfigurationSnapshotTests] {
        let intents = ProgressTrackerIntent.allCases

        return intents.map {
            .init(
                scenario: self,
                intent: $0,
                variant: .outlined,
                state: .normal,
                contentType: .icon,
                size: .medium, 
                orientation: .horizontal,
                labels: [],
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }
}
