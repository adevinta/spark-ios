////
////  CheckboxUIViewActionTests.swift
////  SparkCoreTests
////
////  Created by michael.zimmermann on 13.07.23.
////  Copyright © 2023 Adevinta. All rights reserved.
////
//
//import Combine
//@testable import Spark
//@testable import SparkCore
//import XCTest
//
//final class CheckboxUIViewActionTests: TestCase {
//
//    private var sut: CheckboxUIView!
//    private var theme: Theme!
//    private var delegate: CheckboxUIViewDelegateGeneratedMock!
//    private var subscriptions: Set<AnyCancellable>!
//
//    // MARK: - Setup
//    override func setUp() {
//        super.setUp()
//        self.theme = SparkTheme.shared
//        self.subscriptions = .init()
//        self.delegate = .init()
//    }
//
//    // MARK: - Tests
//    func test_enabled_state_delegate_called() {
//        let sut = sut(state: .enabled, selectionState: .unselected)
//        sut.delegate = self.delegate
//
//        let exp = expectation(description: "Expect changed value to be published")
//
//        sut.publisher.subscribe(in: &self.subscriptions) { state in
//            XCTAssertEqual(state, .selected)
//            exp.fulfill()
//        }
//
//        sut.actionTapped(sender: UIButton())
//
//        wait(for: [exp], timeout: 0.01)
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 1, "Delegate called")
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateReceivedArguments?.state, .selected)
//    }
//
//    func test_error_state_not_selected_delegate_called() {
//        let sut = sut(state: .error(message: "Message"), selectionState: .selected)
//        sut.delegate = self.delegate
//
//        let exp = expectation(description: "Expect changed value to be published")
//
//        sut.publisher.subscribe(in: &self.subscriptions) { state in
//            XCTAssertEqual(state, .unselected)
//            exp.fulfill()
//        }
//
//        sut.actionTapped(sender: UIButton())
//
//        wait(for: [exp], timeout: 0.01)
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 1, "Delegate called")
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateReceivedArguments?.state, .unselected)
//    }
//
//    func test_success_state_indeterminate_delegate_called() {
//        let sut = sut(state: .success(message: "Message"), selectionState: .indeterminate)
//        sut.delegate = self.delegate
//
//        let exp = expectation(description: "Expect changed value to be published")
//
//        sut.publisher.subscribe(in: &self.subscriptions) { state in
//            XCTAssertEqual(state, .selected)
//            exp.fulfill()
//        }
//
//        sut.actionTapped(sender: UIButton())
//
//        wait(for: [exp], timeout: 0.01)
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 1, "Delegate called")
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateReceivedArguments?.state, .selected)
//    }
//
//    func test_disabled_state_nothing_happens() {
//        let sut = self.sut(state: .disabled)
//        sut.delegate = self.delegate
//        sut.actionTapped(sender: UIButton())
//
//        XCTAssertEqual(self.delegate.checkboxWithCheckboxAndStateCallsCount, 0, "Delegate not called")
//    }
//
//    // MARK: Private Helper Functions
//    private func sut(state: SelectButtonState,
//             selectionState: CheckboxSelectionState = .unselected) -> CheckboxUIView {
//        let sut = CheckboxUIView(theme: theme,
//                                 text: "Checkbox",
//                                 checkedImage: IconographyTests.shared.checkmark,
//                                 state: state,
//                                 selectionState: selectionState,
//                                 checkboxAlignment: .left)
//        sut.frame = CGRect(x: 0, y: 0, width: 400, height: 800)
//        return sut
//
//    }
//}
