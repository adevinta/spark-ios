//
//  CheckboxGroupUIView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 19.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import UIKit

/// The `CheckboxGroupUIView` renders a group containing of multiple`CheckboxUIView`-views. It supports a title, different layout and positioning options.
public final class CheckboxGroupUIView: UIView {
    // MARK: - Private properties.

    @Binding private var items: [any CheckboxGroupItemProtocol]
    private var theme: Theme
    private var accessibilityIdentifierPrefix: String
    private var checkboxes: [CheckboxUIView] = []
    private var titleLabel: UILabel?

    // MARK: - Public properties.

    /// The title of the checkbox group displayed on top of the group.
    public var title: String? {
        didSet {
            self.update()
        }
    }

    /// The layout of the checkbox
    public var layout: CheckboxGroupLayout {
        didSet {
            self.update()
        }
    }
    ///  The checkbox is positioned on the leading or trailing edge of the view.
    public var checkboxPosition: CheckboxPosition {
        didSet {
            self.update()
        }
    }

    // MARK: - Initialization

    /// Not implemented. Please use another init.
    /// - Parameter coder: the coder.
    public required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - title: An optional group title displayed on top of the checkbox group..
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxPosition: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        title: String? = nil,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theme: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theme = theme
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.setUpView()
    }

    private func clearView() {
        self.titleLabel?.removeFromSuperview()
        self.titleLabel = nil

        for checkbox in self.checkboxes {
            checkbox.removeFromSuperview()
        }
        self.checkboxes = []
    }

    private var spacing: LayoutSpacing {
        self.theme.layout.spacing
    }

    private func setUpView() {
        self.clearView()
        let view = self

        if let title = self.title, !title.isEmpty {
            let label = UILabel()
            label.text = title
            label.adjustsFontForContentSizeCategory = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = self.theme.colors.base.onSurface.uiColor
            label.font = self.theme.typography.subhead.uiFont

            self.titleLabel = label
            view.addSubview(label)
        }

        var checkboxes: [CheckboxUIView] = []

        for item in self.items {
            let checkbox = CheckboxUIView(
                theme: theme,
                text: item.title,
                state: item.state,
                selectionState: item.selectionState,
                checkboxPosition: self.checkboxPosition,
                selectionStateHandler: { [weak self] state in
                    guard
                        let self,
                        let index = self.items.firstIndex(where: { $0.id == item.id}) else { return }

                    var item = self.items[index]
                    item.selectionState = state
                    self.items[index] = item
                }
            )
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id)"
            checkbox.accessibilityIdentifier = identifier
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(checkbox)
            checkboxes.append(checkbox)
        }

        self.checkboxes = checkboxes

        var previousCheckbox: UIView?

        let horizontalSpacing = self.spacing.large
        if let titleLabel = self.titleLabel {
            let spacing: CGFloat = self.layout == .vertical ? horizontalSpacing : 0
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing).isActive = true
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
        switch self.layout {
        case .vertical:
            for checkbox in checkboxes {
                checkbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing).isActive = true
                checkbox.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing).isActive = true

                if let previousCheckbox = previousCheckbox {
                    checkbox.topAnchor.constraint(equalTo: previousCheckbox.bottomAnchor, constant: horizontalSpacing).isActive = true
                } else {
                    if let titleLabel = self.titleLabel {
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
            let topAnchor = self.titleLabel?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor
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

    /// Triggers an update of the checkbox group.
    public func update() {
        self.setUpView()
    }
}
