//
//  CheckboxGroupUIViewActionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 14.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class CheckboxGroupUIViewActionTests: TestCase {
    // MARK: Private Properties
    private var theme: Theme!
    private var subscriptions: Set<AnyCancellable>!
    private var delegate: CheckboxGroupUIViewDelegateGeneratedMock!
    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Apple", id: "1", selectionState: .selected, state: .error(message: "An unknown error occured.")),
        CheckboxGroupItemDefault(title: "Cake", id: "2", selectionState: .indeterminate),
        CheckboxGroupItemDefault(title: "Fish", id: "3", selectionState: .unselected),
        CheckboxGroupItemDefault(title: "Fruit", id: "4", selectionState: .unselected, state: .success(message: "Great!")),
        CheckboxGroupItemDefault(title: "Vegetables", id: "5", selectionState: .unselected, state: .disabled)
    ]

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = SparkTheme.shared
        self.subscriptions = .init()
        self.delegate = .init()
    }

    // MARK: - Tests
    func test_action_from_checbox_item_propagated() {
        let sut = sut()

        let exp = expectation(description: "Checkbox change should be published")

        sut.publisher.sink { items in
            XCTAssertEqual(items[0].selectionState, .unselected)
            exp.fulfill()
        }.store(in: &self.subscriptions)

        sut.checkboxes[0].actionTapped(sender: UIButton())

        wait(for: [exp], timeout: 0.001)

        XCTAssertEqual(self.delegate.checkboxGroupWithCheckboxGroupAndStateCallsCount, 1)
        XCTAssertEqual(self.delegate.checkboxGroupWithCheckboxGroupAndStateReceivedArguments?.state[0].selectionState, .unselected)
    }

    // MARK: Private Functions
    private func sut() -> CheckboxGroupUIView {
        let sut = CheckboxGroupUIView(checkedImage: IconographyTests.shared.checkmark,
                                   items: self.items,
                                   checkboxAlignment: .left,
                                   theme: self.theme,
                                   accessibilityIdentifierPrefix: "XX")

        sut.delegate = self.delegate
        return sut
    }
}
