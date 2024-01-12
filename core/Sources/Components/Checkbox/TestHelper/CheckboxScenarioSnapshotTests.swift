//
//  CheckboxScenarioSnapshotTests.swift
//  Spark
//
//  Created by alican.aycil on 12.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

@testable import SparkCore

enum CheckboxScenarioSnapshotTests: String, CaseIterable {
    case test1
//    case test2
//    case test3

    // MARK: - Type Alias

    typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Configurations

    func configuration(isSwiftUIComponent: Bool) -> [CheckboxConfigurationSnapshotTests] {
        switch self {
        case .test1:
            return self.test1(isSwiftUIComponent: isSwiftUIComponent)
//        case .test2:
//            return self.test2(isSwiftUIComponent: isSwiftUIComponent)
//        case .test3:
//            return self.test3(isSwiftUIComponent: isSwiftUIComponent)
        }
    }

    // MARK: - Scenarios

    /// Test 1
    ///
    /// Description: To test all intents
    ///
    /// Content:
    ///  - intent: all
    ///  - selectionState: selected
    ///  - state: enabled
    ///  - alignment: left
    ///  - text: normal text
    ///  - modes: all
    ///  - sizes (accessibility): default
    private func test1(isSwiftUIComponent: Bool) -> [CheckboxConfigurationSnapshotTests] {
        let intents = CheckboxIntent.allCases

        return intents.map { intent in
            return .init(
                scenario: self,
                intent: intent,
                selectionState: .selected,
                state: .enabled,
                alignment: .left,
                text: "Hello world", 
                image: UIImage.mock,
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
//    private func test2(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
//            return [.init(
//                scenario: self,
//                rating: 2.5,
//                size: .small,
//                count: .five,
//                modes: Constants.Modes.default,
//                sizes: Constants.Sizes.all
//            )]
//    }

    /// Test 3
    ///
    /// Description: To various rating sizes
    ///
    /// Content:
    ///  - ratings: [2.5]
    ///  - size: [small, medium, input]
    ///  - count: five (number of stars)
    ///  - modes: default
    ///  - accessibility sizes: default
//    private func test3(isSwiftUIComponent: Bool) -> [RatingDisplayConfigurationSnapshotTests] {
//
//        return RatingDisplaySize.allCases.map { size in
//            return .init(
//                scenario: self,
//                rating: 2.5,
//                size: size,
//                count: .five,
//                modes: Constants.Modes.default,
//                sizes: Constants.Sizes.default
//            )
//        }
//    }
}

private extension UIImage {
    static let mock: UIImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
}
