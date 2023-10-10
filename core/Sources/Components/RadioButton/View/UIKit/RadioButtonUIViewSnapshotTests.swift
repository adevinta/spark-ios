//
//  RadioButtonUIViewSnapshotTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 12.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import SparkCore

final class RadioButtonUIViewSnapshotTests: UIKitComponentSnapshotTestCase {

    // MARK: - Properties
    var boundSelectedID = 0

    // MARK: - Tests
    func test_multiline_label() throws {
        let label = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        let sut = sut(groupState: .enabled, isSelected: false, label: label)

        sut.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

        scrollView.addSubview(sut)

        NSLayoutConstraint.activate([
            sut.widthAnchor.constraint(equalToConstant: 400),
            sut.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            sut.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            sut.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            sut.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        assertSnapshot(of: scrollView)
    }

    func test_enabled_selected() throws {
        let view = sut(groupState: .enabled, isSelected: true).fixedSize()
        assertSnapshot(of: view)
    }

    func test_enabled_not_selected() throws {
        let view = sut(groupState: .enabled, isSelected: false).fixedSize()
        assertSnapshot(of: view)
    }

    func test_disabled_not_selected() throws {
        let view = sut(groupState: .disabled, isSelected: false).fixedSize()
        assertSnapshot(of: view)
    }

    func test_disabled_selected() throws {
        let view = sut(groupState: .disabled, isSelected: true).fixedSize()
        assertSnapshot(of: view)
    }

    func test_success_not_selected() throws {
        let view = sut(groupState: .success, isSelected: false).fixedSize()
        assertSnapshot(of: view)
    }

    func test_success_selected() throws {
        let view = sut(groupState: .success, isSelected: true).fixedSize()
        assertSnapshot(of: view)
    }

    func test_warning_not_selected() throws {
        let view = sut(groupState: .warning, isSelected: false).fixedSize()
        assertSnapshot(of: view)
    }

    func test_warning_selected() throws {
        let view = sut(groupState: .warning, isSelected: true).fixedSize()
        assertSnapshot(of: view)
    }

    func test_error_not_selected() throws {
        let view = sut(groupState: .error, isSelected: false).fixedSize()
        assertSnapshot(of: view)
    }

    func test_error_selected() throws {
        let view = sut(groupState: .error, isSelected: true).fixedSize()
        assertSnapshot(of: view)
    }

    func test_label_right() throws {
        let view = sut(groupState: .enabled,
                       isSelected: true,
                       label: NSAttributedString(string: "Label"),
                       labelPosition: .left).fixedSize()
        assertSnapshot(of: view)
    }

    func test_label_with_sublabel_right() throws {
        let view = sut(groupState: .error,
                       isSelected: true,
                       label: NSAttributedString(string: "Label"),
                       labelPosition: .left).fixedSize()
        assertSnapshot(of: view)
    }

    func test_attributed_label_right() throws {
        let label = NSMutableAttributedString(string: "Label")
            .text(" orange ", color: UIColor.orange)
            .symbol("square.and.arrow.up.on.square.fill")
            .text(" green ", color: UIColor.green)

        let view = sut(groupState: .enabled,
                       isSelected: true,
                       label: label,
                       labelPosition: .left).fixedSize()
        assertSnapshot(of: view)
    }

    func test_attributed_label_with_sublabel_right() throws {
        let label = NSMutableAttributedString(string: "Label")
            .text(" red ", color: UIColor.red)
            .symbol("square.and.arrow.up.circle.fill")
            .text(" blue ", color: UIColor.blue)

        let view = sut(groupState: .error,
                       isSelected: true,
                       label: label,
                       labelPosition: .left).fixedSize()
        assertSnapshot(of: view)
    }

    // MARK: - Private Helper Functions
    func sut(groupState: RadioButtonGroupState, isSelected: Bool,
             label: NSAttributedString? = nil,
             labelPosition: RadioButtonLabelPosition = .right) -> RadioButtonUIView<Int> {
        let selectedID = Binding<Int> (
            get: { return self.boundSelectedID },
            set: { self.boundSelectedID = $0 }
        )

        let view = RadioButtonUIView(
            theme: SparkTheme.shared,
            id: isSelected ? self.boundSelectedID : 1,
            label: label ?? groupState.label(isSelected: isSelected),
            selectedID: selectedID,
            groupState: groupState,
            labelPosition: labelPosition
        )

        view.backgroundColor = UIColor.systemBackground
        return view
    }
}

private extension UIView {
    func fixedSize() -> Self {
        let size = intrinsicContentSize
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        return self
    }

    func frame(width: CGFloat, height: CGFloat) -> Self {
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        return self
    }
}

private extension RadioButtonGroupState {
    func label(isSelected: Bool) -> NSAttributedString {
        let selected = isSelected ? "Selected" : "Not Selected"

        switch self {
        case .enabled: return .init(string: "Enabled / \(selected)")
        case .disabled: return .init(string: "Disabled / \(selected)")
        case .error: return .init(string: "Error / \(selected)")
        case .success: return .init(string: "Success / \(selected)")
        case .warning: return .init(string: "Warning / \(selected)")
        case .accent: return .init(string: "Accent / \(selected)")
        case .basic: return .init(string: "Basic / \(selected)")
        }
    }
}

private extension NSMutableAttributedString {
    func text(_ label: String) -> Self {
        self.append(NSAttributedString(string: label))
        return self
    }

    func text(_ label: String, color: UIColor) -> Self {
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : color];
        self.append(NSAttributedString(string: label, attributes: attributedStringColor))
        return self
    }

    func symbol(_ imageName: String) -> Self {
        guard let image = UIImage(systemName: imageName) else { return self }
        let imageAttachment = NSTextAttachment(image: image)
        let imageString = NSAttributedString(attachment: imageAttachment)
        self.append(imageString)
        return self
    }
}

