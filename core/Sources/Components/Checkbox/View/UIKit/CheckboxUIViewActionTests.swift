//
//  CheckboxUIViewActionTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import Spark
@testable import SparkCore
import XCTest

final class CheckboxUIViewActionTests: TestCase {

    private var sut: CheckboxUIView!
    private var theme: Theme!
    private var delegate: CheckboxUIViewDelegateGeneratedMock!
    private var subscriptions: Set<AnyCancellable>!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = SparkTheme.shared
        self.subscriptions = .init()
        self.delegate = .init()
    }

    // MARK: - Tests
    func test_enabled_state_delegate_called() {
        let sut = sut(isEnabled: true, selectionState: .unselected)
        sut.delegate = self.delegate

        let exp = expectation(description: "Expect changed value to be published")
        exp.expectedFulfillmentCount = 2

        var selectionState: CheckboxSelectionState = .unselected

        sut.publisher.subscribe(in: &self.subscriptions) { state in
            selectionState = state
            exp.fulfill()
        }

        sut.actionTapped(sender: UIButton())

        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(selectionState, .selected)
        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 1, "Delegate called")
        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateReceivedArguments?.state, .selected)
    }

    func test_disabled_state_nothing_happens() {
        let sut = self.sut(isEnabled: false)
        sut.delegate = self.delegate
        sut.actionTapped(sender: UIButton())

        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 0, "Delegate not called")
    }

    // MARK: Private Helper Functions
    private func sut(isEnabled: Bool,
             selectionState: CheckboxSelectionState = .unselected) -> CheckboxUIView {
        let sut = CheckboxUIView(theme: theme,
                                 text: "Checkbox",
                                 checkedImage: IconographyTests.shared.checkmark,
                                 isEnabled: isEnabled,
                                 selectionState: selectionState,
                                 checkboxAlignment: .left)
        sut.frame = CGRect(x: 0, y: 0, width: 400, height: 800)
        return sut

    }
}
