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
    private var theming: Theme
    private var accessibilityIdentifierPrefix: String
    private var checkboxes: [CheckboxUIView] = []
    private var titleLabel: UILabel?

    // MARK: - Public properties.

    public var title: String? {
        didSet {
            update()
        }
    }

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
        title: String? = nil,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theming: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
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
        titleLabel?.removeFromSuperview()
        titleLabel = nil

        for checkbox in checkboxes {
            checkbox.removeFromSuperview()
        }
        checkboxes = []
    }

    private var spacing: LayoutSpacing {
        theming.layout.spacing
    }

    private func setUpView() {
        clearView()
        let view = self

        if let title = self.title, !title.isEmpty {
            let label = UILabel()
            label.text = title
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = theming.colors.base.onSurface.uiColor
            label.font = theming.typography.subhead.uiFont

            self.titleLabel = label
            view.addSubview(label)
        }

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

        var previousCheckbox: UIView?

        let horizontalSpacing = spacing.large
        if let titleLabel = self.titleLabel {
            let spacing: CGFloat = layout == .vertical ? horizontalSpacing : 0
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing).isActive = true
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
        switch layout {
        case .vertical:
            for checkbox in checkboxes {
                checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing).isActive = true
                checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing).isActive = true

                if let previousCheckbox = previousCheckbox {
                    checkbox.topAnchor.constraint(equalTo: previousCheckbox.bottomAnchor, constant: horizontalSpacing).isActive = true
                } else {
                    if let titleLabel = titleLabel {
                        checkbox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: horizontalSpacing).isActive = true
                    } else {
                        checkbox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
                    }
                }

                if checkbox == checkboxes.last {
                    checkbox.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                }

                previousCheckbox = checkbox
            }

        case .horizontal:
            let topAnchor = titleLabel?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor
            for checkbox in checkboxes {
                checkbox.topAnchor.constraint(equalTo: topAnchor, constant: horizontalSpacing).isActive = true
                checkbox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -horizontalSpacing).isActive = true

                if let previousCheckbox = previousCheckbox {
                    checkbox.leadingAnchor.constraint(equalTo: previousCheckbox.trailingAnchor, constant: horizontalSpacing).isActive = true
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
