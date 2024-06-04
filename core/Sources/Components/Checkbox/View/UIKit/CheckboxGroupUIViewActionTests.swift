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
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
import SparkTheme

final class CheckboxGroupUIViewActionTests: TestCase {
    // MARK: Private Properties
    private var theme: Theme!
    private var subscriptions: Set<AnyCancellable>!
    private var delegate: CheckboxGroupUIViewDelegateGeneratedMock!
    private var items: [any CheckboxGroupItemProtocol] = [
        CheckboxGroupItemDefault(title: "Apple", id: "1", selectionState:  .selected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Cake", id: "2", selectionState: .indeterminate, isEnabled: true),
        CheckboxGroupItemDefault(title: "Fish", id: "3", selectionState: .unselected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Fruit", id: "4", selectionState: .unselected, isEnabled: true),
        CheckboxGroupItemDefault(title: "Vegetables", id: "5", selectionState: .selected, isEnabled: false)
    ]

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = SparkTheme.shared
        self.subscriptions = .init()
        self.delegate = .init()
    }

    // MARK: - Tests
    func test_action_from_checbox_item_touchUpInside() {
        let sut = sut()

        let exp = expectation(description: "Checkbox change should be published")

        var selectionState: CheckboxSelectionState = .indeterminate

        sut.publisher.sink { items in
            selectionState = items[0].selectionState
            exp.fulfill()
        }.store(in: &self.subscriptions)

        sut.checkboxes[0].sendActions(for: .touchUpInside)

        wait(for: [exp], timeout: 3.0)

        XCTAssertEqual(selectionState, .unselected)
        XCTAssertEqual(self.delegate.checkboxGroupWithCheckboxGroupAndStatesCallsCount, 1)
        XCTAssertEqual(self.delegate.checkboxGroupWithCheckboxGroupAndStatesReceivedArguments?.states[0].selectionState, .unselected)
    }

    // MARK: Private Functions
    private func sut() -> CheckboxGroupUIView {
        let sut = CheckboxGroupUIView(
            checkedImage: IconographyTests.shared.checkmark,
            items: self.items,
            alignment: .left,
            theme: self.theme,
            accessibilityIdentifierPrefix: "XX"
        )

        sut.delegate = self.delegate
        return sut
    }
}
