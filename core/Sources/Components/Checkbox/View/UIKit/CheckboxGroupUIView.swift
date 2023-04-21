//
//  CheckboxGroupUIView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 19.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

public protocol CheckboxGroupUIViewProtocol: AnyObject {
    
}

public final class CheckboxGroupUIView: UIView {
    // MARK: - Private properties.

    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theming: CheckboxTheming
    private var layout: CheckboxGroupLayout
    private var checkboxPosition: CheckboxPosition
    private var accessibilityIdentifierPrefix: String

    // MARK: - Public properties.

    public weak var delegate: CheckboxGroupUIViewProtocol?

    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    public init(
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theming: CheckboxTheming,
        accessibilityIdentifierPrefix: String
    ) {
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theming = theming
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        setUpView()
    }

    private func setUpView() {
        let view = self

        var checkboxes: [CheckboxUIView] = []

        let checkbox = CheckboxUIView(
            theming: theming,
            text: "Hello group!",
            state: .enabled,
            selectionState: .unselected,
            checkboxPosition: .left,
            selectionStateHandler: {
                print("selectionStateHandler", $0)
            }
        )
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox)
        checkboxes.append(checkbox)

        let checkbox2 = CheckboxUIView(
            theming: theming,
            text: "Second checkbox! This is a very very long descriptive text.",
            state: .disabled,
            selectionState: .selected,
            checkboxPosition: .left
        )
        checkbox2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkbox2)
        checkboxes.append(checkbox2)

        let errorCheckbox = CheckboxUIView(
            theming: theming,
            text: "Error checkbox",
            state: .error(message: "Error message"),
            selectionState: .indeterminate,
            checkboxPosition: .left
        )
        errorCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorCheckbox)
        checkboxes.append(errorCheckbox)

        let successCheckbox = CheckboxUIView(
            theming: theming,
            text: "Right checkbox",
            state: .success(message: "Success message"),
            selectionState: .selected,
            checkboxPosition: .right
        )
        successCheckbox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(successCheckbox)
        checkboxes.append(successCheckbox)

        var previousCheckbox: CheckboxUIView?
        for checkbox in checkboxes {
            checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

            if let previousCheckbox = previousCheckbox {
                checkbox.topAnchor.constraint(equalTo: previousCheckbox.safeAreaLayoutGuide.bottomAnchor, constant: 16).isActive = true
            } else {
                checkbox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }

            if checkbox == checkboxes.last {
                checkbox.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

            }

            previousCheckbox = checkbox
        }
    }
}
