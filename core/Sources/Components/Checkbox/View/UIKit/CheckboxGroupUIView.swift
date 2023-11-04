//
//  CheckboxGroupUIView.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 19.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

/// The `CheckboxGroupUIView` renders a group containing of multiple`CheckboxUIView`-views. It supports a title, different layout and positioning options.
public final class CheckboxGroupUIView: UIView {
    // MARK: - Private properties.

    @available(*, deprecated)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.title
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.theme.colors.base.onSurface.uiColor
        label.font = self.theme.typography.subhead.uiFont
        return label
    }()

    @available(*, deprecated)
    private lazy var spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var itemsStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = self.spacingXLarge
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var subscriptions = Set<AnyCancellable>()
    private var items: [any CheckboxGroupItemProtocol]
    private var subject = PassthroughSubject<[any CheckboxGroupItemProtocol], Never>()
    private var accessibilityIdentifierPrefix: String
    @available(*, deprecated)
    private var spacingViewHeightConstraint: NSLayoutConstraint?


    @ScaledUIMetric private var spacingXLarge: CGFloat
    @ScaledUIMetric private var padding: CGFloat = CheckboxControlUIView.Constants.lineWidthPressed
    @available(*, deprecated)
    @ScaledUIMetric private var spacingSmall: CGFloat

    // MARK: - Public properties.

    /// The delegate CheckboxGroupUIViewDelegate` which may be set to retrieve changes to the checkboxes.
    public weak var delegate: CheckboxGroupUIViewDelegate?

    /// Changes to the checkboxgroup are published to the publisher.
    public var publisher: some Publisher<[any CheckboxGroupItemProtocol], Never> {
        return self.subject
    }

    @Published public var theme: Theme {
        didSet {
            self.updateTheme()
        }
    }

    /// The title of the checkbox group displayed on top of the group.
    @available(*, deprecated)
    public var title: String? {
        didSet {
            self.updateTitle()
        }
    }

    /// The tick-checkbox-icon for the selected state.
    public var checkedImage: UIImage {
        didSet {
            self.updateImage()
        }
    }

    /// The layout of the checkbox
    public var layout: CheckboxGroupLayout {
        didSet {
            self.updateLayout()
        }
    }
    ///  The checkbox is positioned on the leading or trailing edge of the view.
    @available(*, deprecated)
    public var checkboxAlignment: CheckboxAlignment {
        didSet {
            self.alignment = self.checkboxAlignment
        }
    }

    public var alignment: CheckboxAlignment {
        didSet {
            self.updateAlignment()
        }
    }

    ///  The checkbox is positioned on the leading or trailing edge of the view.
    public var intent: CheckboxIntent {
        didSet {
            self.updateIntent()
        }
    }

    ///  The checkboxes are items of checkbox group which are created by CheckboxGroupItemProtocol
    public var checkboxes: [CheckboxUIView] {
        self.itemsStackView.arrangedSubviews.compactMap { $0 as? CheckboxUIView }
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
    ///   - checkboxAlignment: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - intent: Current intent of checkbox group
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    @available(*, deprecated)
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: [any CheckboxGroupItemProtocol],
        layout: CheckboxGroupLayout = .vertical,
        checkboxAlignment: CheckboxAlignment,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
        self.checkedImage = checkedImage
        self.items = items
        self.layout = layout
        self.alignment = checkboxAlignment
        self.checkboxAlignment = checkboxAlignment
        self.theme = theme
        self.intent = intent
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        self.spacingXLarge = theme.layout.spacing.xLarge
        self.spacingSmall = theme.layout.spacing.small
        super.init(frame: .zero)
        self.commonInit()
    }

    /// Initialize a group of one or multiple checkboxes.
    /// - Parameters:
    ///   - checkedImage: The tick-checkbox image for checked-state.
    ///   - items: An array containing of multiple `CheckboxGroupItemProtocol`. Each array item is used to render a single checkbox.
    ///   - layout: The layout of the group can be horizontal or vertical.
    ///   - alignment: The checkbox is positioned on the leading or trailing edge of the view.
    ///   - theme: The Spark-Theme.
    ///   - intent: Current intent of checkbox group
    ///   - accessibilityIdentifierPrefix: All checkbox-views are prefixed by this identifier followed by the `CheckboxGroupItemProtocol`-identifier.
    public init(
        checkedImage: UIImage,
        items: [any CheckboxGroupItemProtocol],
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment = .left,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.checkedImage = checkedImage
        self.items = items
        self.layout = layout
        self.alignment = alignment
        self.checkboxAlignment = alignment
        self.theme = theme
        self.intent = intent
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        self.spacingXLarge = theme.layout.spacing.xLarge
        self.spacingSmall = theme.layout.spacing.small
        super.init(frame: .zero)
        self.commonInit()
    }

    private func commonInit() {
        self.setupItemsStackView()
        self.setupView()
    }

    // MARK: - Methods

    /// The trait collection was updated causing the view to update its constraints (e.g. dynamic content size change).
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._spacingXLarge.update(traitCollection: self.traitCollection)
        self._spacingSmall.update(traitCollection: self.traitCollection)
        self._padding.update(traitCollection: self.traitCollection)
    }

    private func setupItemsStackView() {
        for item in self.items {

            var content: Either<NSAttributedString?, String?>

            if let text = item.title {
                content = .left(NSAttributedString(string: text))
            } else {
              content = .left(item.attributedTitle)
            }

            let checkbox = CheckboxUIView(
                theme: theme,
                intent: intent,
                content: content,
                checkedImage: self.checkedImage,
                isEnabled: item.isEnabled,
                selectionState: item.selectionState,
                alignment: self.alignment
            )
            let identifier = "\(self.accessibilityIdentifierPrefix).\(item.id)"

            checkbox.accessibilityIdentifier = identifier
            checkbox.publisher.sink { [weak self] in
                guard
                    let self,
                    let index = self.items.firstIndex(where: { $0.id == item.id})
                else { return }

                var item = self.items[index]
                item.selectionState = $0
                self.items[index] = item
                self.delegate?.checkboxGroup(self, didChangeSelection: self.items)
                self.subject.send(self.items)
            }
            .store(in: &self.subscriptions)

            self.itemsStackView.addArrangedSubview(checkbox)
        }
    }

    private func setupView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.spacingView)
        self.scrollView.addSubview(self.itemsStackView)
        self.addSubview(self.scrollView)

        self.itemsStackView.arrangedSubviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        }

        NSLayoutConstraint.stickEdges(
            from: self.itemsStackView,
            to: self.scrollView,
            insets: UIEdgeInsets(top: self.padding, left: self.padding, bottom: self.padding, right: self.padding)
        )

        self.spacingViewHeightConstraint = self.spacingView.heightAnchor.constraint(equalToConstant: self.titleLabel.isHidden ? 0 : self.padding)
        let constraint = self.itemsStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        constraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.spacingView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.spacingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.spacingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.spacingViewHeightConstraint!,

            self.itemsStackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: -2*self.padding),
            constraint,

            self.scrollView.topAnchor.constraint(equalTo: self.spacingView.bottomAnchor, constant: -self.padding),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -self.padding),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.padding),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.padding),
        ])
    }
}

//MARK: - Updates
extension CheckboxGroupUIView {

    public func updateItems(_ items: [any CheckboxGroupItemProtocol]) {
        self.items.removeAll()
        self.itemsStackView.removeArrangedSubviews()
        self.items = items
        self.setupItemsStackView()
        self.itemsStackView.arrangedSubviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        }
    }

    private func updateTheme() {
        self.spacingXLarge = self.theme.layout.spacing.xLarge
        self.spacingSmall = self.theme.layout.spacing.small
        self.checkboxes.forEach { $0.theme = theme }
    }

    private func updateTitle() {
        if let title = self.title, !title.isEmpty  {
            self.titleLabel.text = title
            self.spacingViewHeightConstraint?.constant = self.spacingSmall
            self.spacingView.isHidden =  false
            self.titleLabel.isHidden = false
        } else {
            self.spacingViewHeightConstraint?.constant = 0
            self.spacingView.isHidden = true
            self.titleLabel.isHidden = true
        }
    }

    private func updateImage() {
        self.checkboxes.forEach { $0.checkedImage = self.checkedImage }
    }

    private func updateLayout() {
        self.itemsStackView.axis = self.layout == .horizontal ? .horizontal : .vertical
        self.itemsStackView.alignment = self.layout == .horizontal ? .top : .fill
    }

    private func updateAlignment() {
        self.checkboxes.forEach { $0.alignment = self.alignment }
    }

    private func updateIntent() {
        self.checkboxes.forEach { $0.intent = self.intent }
    }
}
