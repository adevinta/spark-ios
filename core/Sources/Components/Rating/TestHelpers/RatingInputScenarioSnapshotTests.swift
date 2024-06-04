//
//  RatingInputScenarioSnapshotTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 30.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
@testable import SparkCore
@_spi(SI_SPI) import SparkCommonSnapshotTesting

enum RatingInputScenarioSnapshotTests: String, CaseIterable {
    
    case test1
    case test2
    case test3

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    
    // MARK: - Configurations
    func configuration(isSwiftUIComponent: Bool) -> [RatingInputConfigurationSnapshotTests] {
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
    ///  - ratings: 2.0
    ///  - states: enabled
    ///  - modes: all
    ///  - accessibility sizes: default
    private func test1(isSwiftUIComponent: Bool) -> [RatingInputConfigurationSnapshotTests] {
        let ratings: [CGFloat] = [1.0, 5.0]

        return ratings.map { rating in
            return .init(
                scenario: self,
                rating: rating,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default,
                state: .enabled
            )
        }
    }

    /// Test 2
    ///
    ///
    /// Description: To various accessibility sizes
    ///
    /// Content:
    ///  - ratings: [1.0]
    ///  - modes: default
    ///  - accessibility sizes: all
    ///  - states: all
    private func test2(isSwiftUIComponent: Bool) -> [RatingInputConfigurationSnapshotTests] {
            return [.init(
                scenario: self,
                rating: 1.0,
                modes: Constants.Modes.default,
                sizes: Constants.Sizes.all,
                state: .enabled
            )]
    }

    /// Test 3
    ///
    /// Description: To various rating values
    ///
    /// Content:
    ///  - ratings: [1.0, 5.0]
    ///  - states: disabled, pressed
    ///  - modes: all
    ///  - accessibility sizes: default
    private func test3(isSwiftUIComponent: Bool) -> [RatingInputConfigurationSnapshotTests] {

        return [RatingInputState.disabled, .pressed].map { state in
            return .init(
                scenario: self,
                rating: 2.0,
                modes: Constants.Modes.all,
                sizes: Constants.Sizes.default,
                state: state
            )
        }
    }

}
