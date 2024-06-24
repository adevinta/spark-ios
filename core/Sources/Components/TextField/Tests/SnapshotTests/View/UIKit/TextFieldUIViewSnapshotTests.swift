//
//  TextFieldUIViewSnapshotTests.swift
//  SparkCoreSnapshotTests
//
//  Created by louis.borlee on 12/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
import UIKit
@testable import SparkCore

final class TextFieldUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    private let theme = SparkTheme.shared

    private func _test(scenario: TextFieldScenario) {
        let configurations = self.createConfigurations(from: scenario)
        for configuration in configurations {
            self.assertSnapshot(matching: configuration.view, modes: scenario.modes, sizes: scenario.sizes, testName: configuration.testName)
        }
    }

    func test1() {
        self._test(scenario: TextFieldScenario.test1)
    }

    func test2() {
        self._test(scenario: TextFieldScenario.test2)
    }

    func test3() {
        self._test(scenario: TextFieldScenario.test3)
    }

    func test4() {
        self._test(scenario: TextFieldScenario.test4)
    }

    func test5() {
        self._test(scenario: TextFieldScenario.test5)
    }

    private func createConfigurations(from scenario: TextFieldScenario) -> [(testName: String, view: UIView)] {
        var configurations: [(testName: String, view: UIView)] = []
        for intent in scenario.intents {
            for states in scenario.statesArray {
                for text in scenario.texts {
                    for leftContent in scenario.leftContents {
                        for rightContent in scenario.rightContents {
                            let viewModel = TextFieldViewModel(
                                theme: self.theme,
                                intent: intent,
                                borderStyle: .roundedRect
                            )
                            viewModel.isEnabled = states.isEnabled
                            viewModel.isUserInteractionEnabled = states.isReadOnly != true
                            viewModel.isFocused = states.isFocused
                            let textField = TextFieldUIView(viewModel: viewModel)
                            textField.text = text.text
                            textField.placeholder = text.placeholder
                            textField.clearButtonMode = states.isFocused ? .always : .never
                            textField.leftViewMode = .always
                            textField.rightViewMode = .always
                            textField.leftView = self.getContentViews(from: leftContent)
                            textField.rightView = self.getContentViews(from: rightContent)

                            let backgroundView = UIView()
                            backgroundView.backgroundColor = .systemBackground
                            backgroundView.translatesAutoresizingMaskIntoConstraints = false
                            NSLayoutConstraint.activate([
                                backgroundView.widthAnchor.constraint(equalToConstant: 300)
                            ])

                            backgroundView.addSubview(textField)
                            textField.translatesAutoresizingMaskIntoConstraints = false
                            textField.invalidateIntrinsicContentSize()
                            textField.setNeedsLayout()
                            textField.layoutIfNeeded()
                            NSLayoutConstraint.stickEdges(from: textField, to: backgroundView, insets: .init(all: 12))

                            let testName = scenario.getTestName(
                                intent: intent,
                                states: states,
                                text: text,
                                leftContent:
                                    leftContent,
                                rightContent: rightContent)
                            configurations.append((testName: testName, view: backgroundView))
                        }
                    }
                }
            }
        }
        return configurations
    }

    private func getContentViews(from optionSet: TextFieldScenarioSideContentOptionSet) -> UIView? {
        var contentViews: [UIView] = []
        if optionSet.contains(.button) {
            contentViews.append(self.createButton())
        }
        if optionSet.contains(.image) {
            contentViews.append(self.createImage())
        }
        guard contentViews.isEmpty == false else { return nil }
        if contentViews.count == 1 {
            return contentViews.first
        }
        let stackView = UIStackView(arrangedSubviews: contentViews)
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }

    private func createButton() -> UIButton {
        let button = UIButton(configuration: .filled())
        button.setTitle("Button", for: .normal)
        return button
    }

    private func createImage() -> UIImageView {
        let imageView = UIImageView(image: .init(systemName: "eject.circle.fill"))
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
