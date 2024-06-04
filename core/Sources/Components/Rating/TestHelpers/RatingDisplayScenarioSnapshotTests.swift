//
//  RatingDisplayScenarioSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting

enum RatingDisplayScenarioSnapshotTests: String, CaseIterable {
    case test1
    case test2
    case test3

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1(isSwiftUIComponent: isSwiftUIComponent)
        case .test2:
            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
        case .test3:
            return self.test3(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To various rating values
    ///
    /// Content:
    ///  - ratings: [1.0, 2.5, 5.5]
    ///  - size: medium
    ///  - count: five (number of stars)
    ///  - modes: all
    ///  - accessibility sizes: default
    private func test1(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
        let ratings: [CGFloat] = [1.0, 2.5, 5.5]

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

    /// Test 2
    ///
    ///
    /// Description: To various accessibility sizes
    ///
    /// Content:
    ///  - ratings: [ 2.5]
    ///  - size: small
    ///  - count: five (number of stars)
    ///  - modes: default
    ///  - sizes: all
    private func test2(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
            return [.init(
                scenario: self,
                rating: 2.5,
                size: .small,
                count: .five,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all
            )]
    }

    /// Test 3
    ///
    /// Description: To various rating sizes
    ///
    /// Content:
    ///  - ratings: [2.5]
    ///  - size: [small, medium, large, input]
    ///  - count: five (number of stars)
    ///  - modes: default
    ///  - accessibility sizes: default
    private func test3(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {

        return RatingDisplaySize.allCases.map { size in
            return .init(
                scenario: self,
                rating: 2.5,
                size: size,
                count: .five,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.default
            )
        }
    }
}
