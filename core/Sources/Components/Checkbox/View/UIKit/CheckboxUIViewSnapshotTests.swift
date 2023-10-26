//
//  CheckboxUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 25.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

//import SnapshotTesting
//import SwiftUI
//import XCTest
//
//@testable import SparkCore
//
//final class CheckboxUIViewSnapshotTests: UIKitComponentSnapshotTestCase {
//    let theme: Theme = SparkTheme.shared
//
//    let states = [SelectButtonState.disabled, .enabled, .success(message: "Success message!"), .warning(message: "Warning message!"), .error(message: "Error message!")]
//
//    let checkedImage = IconographyTests.shared.checkmark
//
//    // MARK: -  Tests
//
//    func test_right_aligned() throws {
//        for state in self.states {
//            let checkbox = CheckboxUIView(
//                theme: self.theme,
//                text: "Selected checkbox.",
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .selected,
//                checkboxAlignment: .right
//            )
//
//            assertSnapshotInDarkAndLight(matching: checkbox, named: state.identifier)
//        }
//    }
//
//    func test_checkbox_selected() throws {
//        for state in self.states {
//            let checkbox = CheckboxUIView(
//                theme: self.theme,
//                text: "Selected checkbox.",
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .selected,
//                checkboxAlignment: .left
//            )
//
//            assertSnapshotInDarkAndLight(matching: checkbox, named: state.identifier)
//        }
//    }
//
//    func test_checkbox_unselected() throws {
//        for state in self.states {
//            let checkbox = CheckboxUIView(
//                theme: self.theme,
//                text: "Unselected checkbox.",
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .unselected,
//                checkboxAlignment: .left
//            )
//
//            assertSnapshotInDarkAndLight(matching: checkbox, named: state.identifier)
//        }
//    }
//
//    func test_checkbox_indeterminate() throws {
//        for state in self.states {
//            let checkbox = CheckboxUIView(
//                theme: self.theme,
//                text: "Indeterminate checkbox.",
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .indeterminate,
//                checkboxAlignment: .left
//            )
//
//            assertSnapshotInDarkAndLight(matching: checkbox, named: state.identifier)
//        }
//    }
//
//    func test_checkbox_multiline() throws {
//        for state in self.states {
//            let view = CheckboxUIView(
//                theme: self.theme,
//                text: "Multiline checkbox.\nMore text.",
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .selected,
//                checkboxAlignment: .left
//            )
//
//            assertSnapshotInDarkAndLight(matching: view, named: state.identifier)
//        }
//    }
//
//    func test_checkbox_with_attributed_title() throws {
//        let attributedText = self.attributedCheckboxLabel
//        for state in self.states {
//            let checkbox = CheckboxUIView(
//                theme: self.theme,
//                attributedText: attributedText,
//                checkedImage: self.checkedImage,
//                state: state,
//                selectionState: .selected,
//                checkboxAlignment: .left
//            )
//
//            assertSnapshotInDarkAndLight(matching: checkbox, named: state.identifier)
//        }
//    }
//
//    private var attributedCheckboxLabel: NSAttributedString {
//        let attributedString = NSMutableAttributedString(
//            string: "This text is ",
//            attributes: [
//                .font: self.theme.typography.body1.uiFont
//            ]
//        )
//        let boldString = NSAttributedString(
//            string: "bold",
//            attributes: [
//                .font: self.theme.typography.body1Highlight.uiFont,
//                .foregroundColor: self.theme.colors.feedback.success.uiColor
//            ]
//        )
//        attributedString.append(boldString)
//        return attributedString
//    }
//}
