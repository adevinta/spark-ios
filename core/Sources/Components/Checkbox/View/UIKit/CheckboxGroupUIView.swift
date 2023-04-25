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
    private var accessibilityIdentifierPrefix: String
    private var checkboxes: [CheckboxUIView] = []

    // MARK: - Public properties.

    public weak var delegate: CheckboxGroupUIViewProtocol?

    public var layout: CheckboxGroupLayout {
        didSet {
            update()
        }
    }
    public var checkboxPosition: CheckboxPosition {
        didSet {
            update()
        }
    }

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

    private func clearView() {
        for checkbox in checkboxes {
            checkbox.removeFromSuperview()
        }
        checkboxes = []
    }

    private func setUpView() {
        clearView()
        let view = self

        var checkboxes: [CheckboxUIView] = []

        for item in items {
            let checkbox = CheckboxUIView(
                theming: theming,
                text: item.title,
                state: item.state,
                selectionState: item.selectionState,
                checkboxPosition: checkboxPosition,
                selectionStateHandler: { [weak self] state in
                    print("selectionStateHandler", state)
                    guard
                        let self,
                        let index = self.items.firstIndex(where: { $0.id == item.id}) else { return }

                    var item = self.items[index]
                    item.selectionState = state
                    self.items[index] = item
                }
            )
            let identifier = "\(accessibilityIdentifierPrefix).\(item.id)"
            checkbox.accessibilityIdentifier = identifier
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(checkbox)
            checkboxes.append(checkbox)
        }

        self.checkboxes = checkboxes

        var previousCheckbox: CheckboxUIView?

        switch layout {
        case .vertical:
            for checkbox in checkboxes {
                checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
                checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true

                if let previousCheckbox = previousCheckbox {
                    checkbox.topAnchor.constraint(equalTo: previousCheckbox.bottomAnchor, constant: 16).isActive = true
                } else {
                    checkbox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
                }

                if checkbox == checkboxes.last {
                    checkbox.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

                }

                previousCheckbox = checkbox
            }

        case .horizontal:
            for checkbox in checkboxes {
                checkbox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
                checkbox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

                if let previousCheckbox = previousCheckbox {
                    checkbox.leadingAnchor.constraint(equalTo: previousCheckbox.trailingAnchor, constant: 16).isActive = true
                } else {
                    checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
                }

                if checkbox == checkboxes.last {
                    checkbox.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

                }

                previousCheckbox = checkbox
            }
            
        }
    }

    public func update() {
        setUpView()
    }
}
