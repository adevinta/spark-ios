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
    @Published public var theme: Theme {
        didSet {
            self.spacingXLarge = self.theme.layout.spacing.xLarge

            self.updateViewConstraints()
            for checkbox in self.checkboxes {
                checkbox.theme = self.theme
            }
        }
    }
    private var accessibilityIdentifierPrefix: String
    private var checkboxes: [CheckboxUIView] = []
    private var titleLabel: UILabel?

    private var titleLabelBottomConstraint: NSLayoutConstraint?
    private var checkboxVerticalSpacingConstraints: [NSLayoutConstraint] = []
    private var checkboxHorizontalSpacingConstraints: [NSLayoutConstraint] = []

    @ScaledUIMetric private var spacingXLarge: CGFloat

    // MARK: - Public properties.

    /// The title of the checkbox group displayed on top of the group.
    public var title: String? {
        didSet {
            self.update()
        }
    }

    /// The tick-checkbox-icon for the selected state.
    public let checkedImage: UIImage

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
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - checkboxPosition: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: Binding<[any CheckboxGroupItemProtocol]>,
        layout: CheckboxGroupLayout = .vertical,
        checkboxPosition: CheckboxPosition,
        theme: Theme,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
        self.checkedImage = checkedImage
        self._items = items
        self.layout = layout
        self.checkboxPosition = checkboxPosition
        self.theme = theme
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        self.spacingXLarge = theme.layout.spacing.xLarge
        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.setUpView()
    }

    // MARK: - Methods

    /// The trait collection was updated causing the view to update its constraints (e.g. dynamic content size change).
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacingXLarge.update(traitCollection: self.traitCollection)

        self.updateViewConstraints()
    }

    private func updateViewConstraints() {
        let spacing = self.spacingXLarge
        for constraint in self.checkboxVerticalSpacingConstraints {
            constraint.constant = spacing
        }

        for constraint in self.checkboxHorizontalSpacingConstraints {
            constraint.constant = spacing
        }

        self.titleLabelBottomConstraint?.constant = spacing
    }

    private func clearView() {
        self.titleLabel?.removeFromSuperview()
        self.titleLabel = nil

        for checkbox in self.checkboxes {
            checkbox.removeFromSuperview()
        }
        self.checkboxes = []

        self.titleLabelBottomConstraint = nil
        self.checkboxVerticalSpacingConstraints = []
        self.checkboxHorizontalSpacingConstraints = []
    }

    private var spacing: LayoutSpacing {
        self.theme.layout.spacing
    }

    private func setUpView() {
        self.clearView()
        let view = self

        if let title = self.title, !title.isEmpty {
            let label = UILabel()
            label.numberOfLines = 0
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
            let content: Either<NSAttributedString, String>
            if let attributedTitle = item.attributedTitle {
                content = .left(attributedTitle)
            } else {
                content = .right(item.title ?? "")
            }
            let checkbox = CheckboxUIView(
                theme: theme,
                content: content,
                checkedImage: self.checkedImage,
                state: item.state,
                selectionState: .init(
                    get: {
                        return item.selectionState
                    },
                    set: { [weak self] in
                        guard
                            let self,
                            let index = self.items.firstIndex(where: { $0.id == item.id}) else { return }

                        var item = self.items[index]
                        item.selectionState = $0
                        self.items[index] = item
                    }
                ),
                checkboxPosition: self.checkboxPosition
            )
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id)"
            checkbox.accessibilityIdentifier = identifier
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(checkbox)
            checkboxes.append(checkbox)
        }

        self.checkboxes = checkboxes

        self.setUpGroupConstraints()
    }

    private func setUpGroupConstraints() {
        let view = self
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
                    let constraint = checkbox.topAnchor.constraint(equalTo: previousCheckbox.bottomAnchor, constant: self.spacingXLarge)
                    constraint.isActive = true
                    checkboxVerticalSpacingConstraints.append(constraint)
                } else {
                    if let titleLabel = self.titleLabel {
                        titleLabelBottomConstraint = checkbox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: self.spacingXLarge)
                        titleLabelBottomConstraint?.isActive = true
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
                let spacingConstraint = checkbox.topAnchor.constraint(equalTo: topAnchor, constant: self.spacingXLarge)
                spacingConstraint.isActive = true
                checkboxVerticalSpacingConstraints.append(spacingConstraint)

                checkbox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -horizontalSpacing).isActive = true

                if let previousCheckbox = previousCheckbox {
                    let spacingConstraint = checkbox.leadingAnchor.constraint(equalTo: previousCheckbox.trailingAnchor, constant: self.spacingXLarge)
                    spacingConstraint.isActive = true
                    checkboxHorizontalSpacingConstraints.append(spacingConstraint)
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
