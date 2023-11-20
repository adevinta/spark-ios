//
//  RatingDisplayScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

@testable import SparkCore
import UIKit
import SwiftUI

enum RatingDisplayScenarioSnapshotTests: String, CaseIterable {
    case test1
//    case test2
//    case test3
//    case test4
//    case test5

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
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
    ///  - content: icon + text
    ///  - state: default
    ///  - mode: all
    ///  - size: default
    private func test1(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
        let ratings: [CGFloat] = [0.0, 1.0, 2.5, 5.5]

        return ratings.map { rating in
            return .init(
                scenario: self,
                rating: rating,
                size: .medium,
                count: .five,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default
            )
        }
    }
}
