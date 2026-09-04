//
//  SparkUIXXXSnapshotTests.swift
//  SparkComponentXXXSnapshotTests
//
//  Created by robin.lemaire on 03/03/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import XCTest
import UIKit
import SnapshotTesting
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommonTesting
@testable import SparkComponentXXX
import SparkTheming
import SparkTheme

final class SparkUIXXXSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared

    // MARK: - Tests

    func test() {
        let scenarios = XXXScenarioSnapshotTests.allCases.filter {
            $0 != .documentation
        }

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {
                let view = self.component(configuration: configuration)

                let containerView = self.containerView(for: view)

                self.assertSnapshot(
                    matching: containerView,
                    named: configuration.name,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName
                )
            }
        }
    }

    func testOther() {
        let scenarios = XXXScenarioOtherSnapshotTests.allCases

        for scenario in scenarios {
            let configurations = scenario.configuration()

            for configuration in configurations {
                let view = self.component(configuration: configuration)

                let containerView = self.containerView(for: view)

                self.assertSnapshot(
                    matching: containerView,
                    named: configuration.name,
                    modes: [.light],
                    sizes: [.accessibilityLarge],
                    testName: configuration.testName
                )
            }
        }
    }

    // MARK: - Component Creation

    private func component(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        let xxx = switch configuration.content {
        case .text:
            self.componentWithText(configuration: configuration)

        case .icon:
            self.componentWithIcon(configuration: configuration)

        case .textAndIcon:
            self.componentWithTextAndIcon(configuration: configuration)

        case .textAndExtraView:
            self.componentWithTextAndExtraView(configuration: configuration)

        case .iconAndExtraView:
            self.componentWithIconAndExtraView(configuration: configuration)

        case .allValues:
            self.componentWithAllValues(configuration: configuration)
        }

        // Populate the xxx
        xxx.intent = configuration.intent
        xxx.size = configuration.size
        xxx.apportionsSegmentWidthsByContent = configuration.apportionsSegmentWidthsByContent
        xxx.selectedSegmentIndex = configuration.selectedIndex

        return xxx
    }

    private func componentWithText(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        return switch configuration.contentType {
        case .text:
            SparkUIXXX(
                theme: self.theme,
                titles: [.mock1, .mock2, .mock3]
            )

        case .custom:
            SparkUIXXX(
                theme: self.theme,
                segments: [
                    XXXUISegment(attributedTitle: .mock(text: .mock1)),
                    XXXUISegment(attributedTitle: .mock(text: .mock2)),
                    XXXUISegment(attributedTitle: .mock(text: .mock3))
                ]
            )
        }
    }

    private func componentWithIcon(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        return SparkUIXXX(
            theme: self.theme,
            images: [.mock1, .mock2, .mock3]
        )
    }

    private func componentWithTextAndIcon(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        let segments: [XXXUISegment] = switch configuration.contentType {
        case .text:
            [
                XXXUISegment(title: .mock1, image: .mock1),
                XXXUISegment(title: .mock2, image: .mock2),
                XXXUISegment(title: .mock3, image: .mock3)
            ]

        case .custom:
            [
                XXXUISegment(attributedTitle: .mock(text: .mock1), image: .mock1),
                XXXUISegment(attributedTitle: .mock(text: .mock2), image: .mock2),
                XXXUISegment(attributedTitle: .mock(text: .mock3), image: .mock3)
            ]
        }

        return SparkUIXXX(theme: self.theme, segments: segments)
    }

    private func componentWithTextAndExtraView(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        let xxx = self.componentWithText(configuration: configuration)

        // Add extra views (badges)
        xxx.addExtraViews()

        return xxx
    }

    private func componentWithIconAndExtraView(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        let xxx = SparkUIXXX(
            theme: self.theme,
            images: [.mock1, .mock2, .mock3]
        )

        // Add extra views (badges)
        xxx.addExtraViews()

        return xxx
    }

    private func componentWithAllValues(configuration: XXXConfigurationSnapshotTests) -> SparkUIXXX {
        let segments: [XXXUISegment] = switch configuration.contentType {
        case .text:
            [
                XXXUISegment(title: .mock1, image: .mock1),
                XXXUISegment(title: .mock2, image: .mock2),
                XXXUISegment(title: .mock3, image: .mock3)
            ]

        case .custom:
            [
                XXXUISegment(attributedTitle: .mock(text: .mock1), image: .mock1),
                XXXUISegment(attributedTitle: .mock(text: .mock2), image: .mock2),
                XXXUISegment(attributedTitle: .mock(text: .mock3), image: .mock3)
            ]
        }

        let xxx = SparkUIXXX(theme: self.theme, segments: segments)

        // Add extra views (badges)
        xxx.addExtraViews()

        return xxx
    }

    // MARK: - Other Component Creation

    private func component(configuration: XXXConfigurationOtherSnapshotTests) -> SparkUIXXX {
        return switch configuration.operation {
        case .addSegment:
            self.componentWithAddSegment(configuration: configuration)
        case .insertSegment:
            self.componentWithInsertSegment(configuration: configuration)
        case .removeSegment:
            self.componentWithRemoveSegment(configuration: configuration)
        }
    }

    // MARK: - Add Segment Components

    private func componentWithAddSegment(configuration: XXXConfigurationOtherSnapshotTests) -> SparkUIXXX {
        let xxx = self.componentWithText(configuration: configuration.mainConfiguration)

        // Add segment based on content type
        switch configuration.contentType {
        case .title:
            xxx.addSegment(
                with: String.new,
                animated: false
            )

        case .attributedTitle:
            xxx.addSegment(
                with: .mock(text: .new),
                animated: false
            )

        case .image:
            xxx.addSegment(
                with: UIImage.new,
                animated: false
            )

        case .model:
            xxx.addSegment(
                with: .init(title: .new, image: .new),
                animated: false
            )
        }

        return xxx
    }

    // MARK: - Insert Segment Components

    private func componentWithInsertSegment(configuration: XXXConfigurationOtherSnapshotTests) -> SparkUIXXX {
        let xxx = self.componentWithText(configuration: configuration.mainConfiguration)

        // Determine initial titles and indices based on insert position
        let (insertIndex, selectedIndex): (Int, Int) = switch configuration.insertPosition {
        case .beginning:
            (0, 0)
        case .middle:
            (1, 0)
        case .end:
            (xxx.numberOfSegments, 0)
        case .beforeSelected:
            (1, 1)
        case .afterSelected:
            (2, 1)
        }

        // Set selected index
        xxx.selectedSegmentIndex = selectedIndex

        // Insert segment based on content type
        switch configuration.contentType {
        case .title:
            xxx.insertSegment(
                with: String.new,
                at: insertIndex,
                animated: false
            )

        case .attributedTitle:
            xxx.insertSegment(
                with: NSAttributedString.mock(text: .new),
                at: insertIndex,
                animated: false
            )

        case .image:
            xxx.insertSegment(
                with: UIImage.new,
                at: insertIndex,
                animated: false
            )

        case .model:
            xxx.insertSegment(
                with: .init(title: .new, image: .new),
                at: insertIndex,
                animated: false
            )
        }

        return xxx
    }

    // MARK: - Remove Segment Components

    private func componentWithRemoveSegment(configuration: XXXConfigurationOtherSnapshotTests) -> SparkUIXXX {
        let xxx = self.componentWithText(configuration: configuration.mainConfiguration)

        // Determine remove index and selected index based on remove position
        let (removeIndex, selectedIndex): (Int, Int) = switch configuration.removePosition {
        case .beginning:
            (0, 1)
        case .middle:
            (1, 0)
        case .end:
            (xxx.numberOfSegments - 1, 0)
        case .selected:
            (1, 1)
        case .lastSelected:
            (2, 2)
        case .beforeSelected:
            (0, 2)
        }

        // Set selected index
        xxx.selectedSegmentIndex = selectedIndex

        // Remove segment
        xxx.removeSegment(at: removeIndex, animated: false)

        return xxx
    }

    // MARK: - Helper Methods

    private func containerView(
        for xxx: SparkUIXXX
    ) -> UIView {
        // Create container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBackground

        container.addSubview(xxx)

        let width: CGFloat = .width(apportionsSegmentWidthsByContent: xxx.apportionsSegmentWidthsByContent)

        NSLayoutConstraint.activate([
            xxx.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            xxx.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            xxx.topAnchor.constraint(equalTo: container.topAnchor),
            xxx.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            container.widthAnchor.constraint(equalToConstant: width)
        ])

        return container
    }
}

// MARK: - Extension

private extension SparkUIXXX {

    func addExtraViews() {
        self.setExtraView(.createBadgeView(text: "2"), forSegmentAt: 0)
        self.setExtraView(.createBadgeView(text: "5"), forSegmentAt: 1)
    }
}

private extension UIView {

    static func createBadgeView(text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 8)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .red
        label.layer.cornerRadius = 6
        label.clipsToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 12),
            label.heightAnchor.constraint(equalToConstant: 12)
        ])

        return label
    }
}

private extension NSAttributedString {

    static func mock(text: String) -> NSAttributedString {
        let attributedString = NSMuxxxleAttributedString(string: text)
        attributedString.append(NSAttributedString(
            string: " (*)",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize),
                .foregroundColor: UIColor.systemBlue
            ]
        ))
        return attributedString
    }
}

private extension String {

    static var new: Self {
        "New"
    }
}

private extension UIImage {

    static var mock1: UIImage {
        UIImage(systemName: "house") ?? UIImage()
    }

    static var mock2: UIImage {
        UIImage(systemName: "star") ?? UIImage()
    }

    static var mock3: UIImage {
        UIImage(systemName: "person") ?? UIImage()
    }

    static var new: UIImage {
        UIImage(systemName: "display") ?? UIImage()
    }
}
