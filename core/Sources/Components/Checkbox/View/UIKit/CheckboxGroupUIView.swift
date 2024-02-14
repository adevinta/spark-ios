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
public final class CheckboxGroupUIView: UIControl {
    // MARK: - Private properties.

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.title
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.theme.colors.base.onSurface.uiColor
        label.font = self.theme.typography.subhead.uiFont
        label.accessibilityIdentifier = CheckboxAccessibilityIdentifier.checkboxGroupTitle
        return label
    }()

    private lazy var spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.titleLabel, self.spacingView])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var itemsStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = self.spacingLarge
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

    @ScaledUIMetric private var spacingLarge: CGFloat
    @ScaledUIMetric private var padding: CGFloat = CheckboxControlUIView.Constants.lineWidthPressed
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
    @available(*, deprecated, message: "alignment will be used instead of this")
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
    public init(
        title: String? = nil,
        checkedImage: UIImage,
        items: [any CheckboxGroupItemProtocol],
        layout: CheckboxGroupLayout = .vertical,
        alignment: CheckboxAlignment = .left,
        theme: Theme,
        intent: CheckboxIntent = .main,
        accessibilityIdentifierPrefix: String
    ) {
        self.title = title
        self.checkedImage = checkedImage
        self.items = items
        self.layout = layout
        self.alignment = alignment
        self.checkboxAlignment = alignment
        self.theme = theme
        self.intent = intent
        self.accessibilityIdentifierPrefix = accessibilityIdentifierPrefix
        self.spacingLarge = theme.layout.spacing.large
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

        self._spacingLarge.update(traitCollection: self.traitCollection)
        self._spacingSmall.update(traitCollection: self.traitCollection)
        self._padding.update(traitCollection: self.traitCollection)
    }

    private func setupItemsStackView() {
        self.updateLayout()
        
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
                checkedImage: .left(self.checkedImage),
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
                self.sendActions(for: .valueChanged)
            }
            .store(in: &self.subscriptions)

            self.itemsStackView.addArrangedSubview(checkbox)
        }
    }

    private func setupView() {

        self.accessibilityIdentifier =  "\(self.accessibilityIdentifierPrefix).\(CheckboxAccessibilityIdentifier.checkboxGroup)"

        self.addSubview(self.titleStackView)
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

        let constraint = self.itemsStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        constraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            self.titleStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            self.spacingView.heightAnchor.constraint(equalToConstant: self.spacingSmall),

            self.itemsStackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: -2*self.padding),
            constraint,

            self.scrollView.topAnchor.constraint(equalTo: self.titleStackView.bottomAnchor, constant: -self.padding),
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
        self.spacingLarge = self.theme.layout.spacing.large
        self.spacingSmall = self.theme.layout.spacing.small
        self.checkboxes.forEach { $0.theme = theme }
    }

    private func updateTitle() {
        if let title = self.title, !title.isEmpty  {
            self.titleLabel.text = title
            self.spacingView.isHidden =  false
            self.titleLabel.isHidden = false
        } else {
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
