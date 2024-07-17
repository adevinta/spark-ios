//
//  ComponentUIView.swift
//  Spark
//
//  Created by robin.lemaire on 25/08/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

class ComponentUIView: UIView {

    // MARK: - UIViews

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.accessibilityIdentifier = self.viewModel.identifier + "ScrollView"
        scrollView.addSubview(self.contentStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.configurationView,
            self.separationLineView,
            self.integrationStackView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = self.viewModel.identifier + "StackView"
        return stackView
    }()

    private lazy var configurationView: ComponentsConfigurationUIView = {
        return .init(
            viewModel: self.viewModel.configurationViewModel
        )
    }()

    private lazy var separationLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var integrationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.integrationLabel,
                self.componentStackView
            ]
        )
        stackView.axis = .vertical
        stackView.alignment = self.integrationStackViewAlignment
        stackView.spacing = 12
        return stackView
    }()

    private lazy var integrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Integration"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var componentHStack: UIStackView = {
        let horizontalStackView = UIStackView(
            arrangedSubviews: [
                self.componentLeftSpaceView,
                self.componentView,
                self.componentRightSpaceView
            ]
        )
        horizontalStackView.spacing = 16
        horizontalStackView.axis = .horizontal
        return horizontalStackView
    }()

    lazy var componentStackView: UIStackView = {

        let verticalStackView = UIStackView(
            arrangedSubviews: [
                self.componentTopSpaceView,
                componentHStack,
                self.componentBottomSpaceView
            ]
        )
        verticalStackView.spacing = 16
        verticalStackView.axis = .vertical

        return verticalStackView
    }()

    private var componentView: UIView

    lazy var componentLeftSpaceView: UIView = {
        let view = UIView()
        view.spaceContainer(for: .left)
        return view
    }()

    var componentTopSpaceView: UIView = {
        let view = UIView()
        view.spaceContainer(for: .top)
        return view
    }()

    lazy var componentRightSpaceView: UIView = {
        let view = UIView()
        view.spaceContainer(for: .right)
        return view
    }()

    lazy var componentBottomSpaceView: UIView = {
        let view = UIView()
        view.spaceContainer(for: .bottom)
        return view
    }()

    // MARK: - Properties

    private let viewModel: ComponentUIViewModel

    weak var viewController: UIViewController?

    var showRightSpacing: Bool = false {
        didSet {
            self.updateSpaceContainerViews()
        }
    }

    var integrationStackViewAlignment: UIStackView.Alignment {
        didSet {
            self.integrationStackView.alignment = self.integrationStackViewAlignment
        }
    }

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(viewModel: ComponentUIViewModel,
         integrationStackViewAlignment: UIStackView.Alignment = .leading,
         componentView: UIView) {
        self.viewModel = viewModel
        self.integrationStackViewAlignment = integrationStackViewAlignment

        self.componentView = componentView

        super.init(frame: .zero)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        // Properties
        self.backgroundColor = .systemBackground
        self.accessibilityIdentifier = self.viewModel.identifier

        // Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.tagGestureRecognizerAction)
        )
        self.addGestureRecognizer(tapGestureRecognizer)

        // Subviews
        self.addSubview(self.scrollView)

        // Spacing
        self.updateSpaceContainerViews()

        // Add constraints
        self.setupConstraints()

        // Setup
        self.setupSubscriptions()
    }

    private func setupConstraints() {
        // ScrollView
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        // Content StackView
        let spacing: CGFloat = 16
        NSLayoutConstraint.stickEdges(
            from: self.contentStackView,
            to: self.scrollView,
            insets: .init(top: 0, left: spacing, bottom: 0, right: spacing)
        )

        // Width & Separation Line View
        NSLayoutConstraint.activate([
            self.contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -spacing * 2),
            self.separationLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    // MARK: - Update UI

    func updateSpaceContainerViews() {
        let type = self.viewModel.spaceContainerType

        self.componentLeftSpaceView.isHidden = !SpaceContainer.left.showSpaceContainer(
            from: type
        )
        self.componentTopSpaceView.isHidden = !SpaceContainer.top.showSpaceContainer(
            from: type
        )
        self.componentRightSpaceView.isHidden = !(SpaceContainer.right.showSpaceContainer(
            from: type
        ) || self.showRightSpacing)
        self.componentBottomSpaceView.isHidden = !SpaceContainer.bottom.showSpaceContainer(
            from: type
        )

        self.componentView.setNeedsLayout()
        self.componentView.layoutIfNeeded()
        self.componentView.contentMode = .scaleToFill
        self.componentView.sizeToFit()
    }

    func updateComponentView(_ view: UIView) {
        self.componentView.removeFromSuperview()
        self.componentView = view
        self.componentHStack.insertArrangedSubview(self.componentView, at: 1)
    }

    // MARK: - Subscribe

    private func setupSubscriptions() {
        self.viewModel.$spaceContainerType.subscribe(in: &self.subscriptions, on: RunLoop.main) { [weak self] type in
            guard let self = self else { return }
            self.viewModel.spaceContainerTypeConfigurationItemViewModel.buttonTitle = type.name
            self.updateSpaceContainerViews()
        }

        self.viewModel.showSpaceContainerTypeSheet.subscribe(in: &self.subscriptions) { types in
            self.presentIntentActionSheet(types)
        }
    }

    // MARK: - Navigation

    private func presentIntentActionSheet(_ spaceContainerTypes: [SpaceContainerType]) {
        guard let viewController = self.viewController else {
            return
        }

        let actionSheet = SparkActionSheet<SpaceContainerType>.init(
            values: spaceContainerTypes,
            texts: spaceContainerTypes.map { $0.name }) { type in
                self.viewModel.spaceContainerType = type
            }
        viewController.present(actionSheet, isAnimated: true)
    }

    // MARK: - Action

    @objc
    func tagGestureRecognizerAction() {
        Console.log("View tapped from gesture")
    }
}

// MARK: - Extension

private extension UIView {

    func spaceContainer(for spaceContainer: SpaceContainer) {
        self.backgroundColor = SparkTheme.shared.colors.main.mainContainer.uiColor
        self.layer.cornerRadius = SparkTheme.shared.border.radius.medium

        self.translatesAutoresizingMaskIntoConstraints = false
        if let fixedWidth = spaceContainer.fixedWidth {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: fixedWidth).isActive = true
        }
        if let fixedHeight = spaceContainer.fixedHeight {
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: fixedHeight).isActive = true
        }
    }
}
