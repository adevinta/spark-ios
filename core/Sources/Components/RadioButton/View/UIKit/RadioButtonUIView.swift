//
//  RadioButtonUIView.swift
//  Spark
//
//  Created by michael.zimmermann on 18.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

// MARK: - Constants
private enum Constants {
    static let toggleViewHeight: CGFloat = 28
    static let toggleViewSpacing: CGFloat = 4
    static let toggleViewPadding: CGFloat = 6
    static let textLabelTopSpacing: CGFloat = 3
}

public final class RadioButtonUIView<ID: Equatable & CustomStringConvertible>: UIView {

    // MARK: Injected Properties
    private let viewModel: RadioButtonViewModel<ID>

    public var theme: Theme {
        get {
            return self.viewModel.theme
        }
        set {
            self.viewModel.set(theme: newValue)
        }
    }

    public var state: SparkSelectButtonState {
        get {
            return self.viewModel.state
        }
        set {
            self.viewModel.set(state: newValue)
        }
    }

    public var label: String {
        get {
            return self.viewModel.label
        }
        set {
            self.viewModel.label = newValue
        }
    }

    // MARK: Private Properties
    @ScaledUIMetric private var size = Constants.toggleViewHeight
    @ScaledUIMetric private var spacing = Constants.toggleViewSpacing
    @ScaledUIMetric private var toggleViewPadding = Constants.toggleViewPadding
    @ScaledUIMetric private var textLabelTopSpacing = Constants.textLabelTopSpacing

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - View properties
    private let toggleView: RadioButtonToggleUIView = {
        let toggleView = RadioButtonToggleUIView()
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.backgroundColor = .clear
        toggleView.sizeToFit()

        return toggleView
    }()
    private let labelView = UILabel.standard
    private let supplementaryLabelView = UILabel.standard
    private let button = UIButton(type: .custom)

    // MARK: - Constraint properties
    private var toggleViewWidthConstraint: NSLayoutConstraint?
    private var toggleViewHeightConstraint: NSLayoutConstraint?
    private var toggleViewSpacingConstraint: NSLayoutConstraint?
    private var labelViewTopConstraint: NSLayoutConstraint?
    private var labelViewBottomConstraint: NSLayoutConstraint?
    private var toggleViewTopConstraint: NSLayoutConstraint?

    //  MARK: - Initialization
    public convenience init(theme: Theme,
                            id: ID,
                            label: String,
                            selectedId: Binding<ID>,
                            state: SparkSelectButtonState = .enabled
    ) {
        let viewModel = RadioButtonViewModel(theme: theme, id: id, label: label, selectedID: selectedId, state: state)

        self.init(viewModel: viewModel)
    }

    init(viewModel: RadioButtonViewModel<ID>) {
        self.viewModel = viewModel

        super.init(frame: CGRect.zero)

        self.arrangeViews()
        self.setupButtonActions(isDisabled: viewModel.isDisabled)
        self.updateViewAttributes()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func toggleNeedsRedisplay(_ selected: ID) {
        let radioButtonColors = self.viewModel.colorsFor(selectedID: selected)
        self.updateColors(radioButtonColors)
        self.toggleView.isChanged = true
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self._size.update(traitCollection: self.traitCollection)
        self._spacing.update(traitCollection: self.traitCollection)
        self._toggleViewPadding.update(traitCollection: self.traitCollection)
        self._textLabelTopSpacing.update(traitCollection: self.traitCollection)

        toggleViewSpacingConstraint?.constant = -self.spacing
        toggleViewWidthConstraint?.constant = self.size
        toggleViewHeightConstraint?.constant = self.size
        toggleViewTopConstraint?.constant = self.toggleViewPadding

        labelViewTopConstraint?.constant = self.textLabelTopSpacing
        labelViewBottomConstraint?.constant = -(self.toggleViewPadding+self.textLabelTopSpacing)
    }


    // MARK: - Private functions

    private func setupSubscriptions() {
        self.viewModel.$opacity
            .receive(on: RunLoop.main)
            .sink { [weak self] opacity in
            self?.alpha = opacity
        }
        .store(in: &self.subscriptions)

        self.viewModel.$colors
            .receive(on: RunLoop.main)
            .sink { [weak self] colors in
            self?.updateColors(colors)
        }.store(in: &self.subscriptions)

        self.viewModel.$isDisabled
            .receive(on: RunLoop.main)
            .sink { [weak self] isDisabled in
            self?.setupButtonActions(isDisabled: isDisabled)
        }.store(in: &self.subscriptions)

        self.viewModel.$font
            .receive(on: RunLoop.main)
            .sink { [weak self] font in
            self?.labelView.font = font.uiFont
        }.store(in: &self.subscriptions)

        self.viewModel.$supplemetaryFont
            .receive(on: RunLoop.main)
            .sink { [weak self] supplementaryFont in
            self?.supplementaryLabelView.font = supplementaryFont.uiFont
        }.store(in: &self.subscriptions)

        self.viewModel.$supplementaryText
            .receive(on: RunLoop.main)
            .sink { [weak self] supplementaryText in
            self?.supplementaryLabelView.text = supplementaryText
        }.store(in: &self.subscriptions)

        self.viewModel.$label
            .receive(on: RunLoop.main)
            .sink {  [weak self] label in
            self?.labelView.text = label
        }.store(in: &self.subscriptions)
    }

    private func arrangeViews() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.toggleView)
        self.addSubview(self.labelView)
        self.addSubview(self.supplementaryLabelView)

        self.button.translatesAutoresizingMaskIntoConstraints = true
        self.button.frame = self.bounds
        self.button.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(self.button)

        self.setupConstraints()
        self.labelView.text = self.viewModel.label
    }

    private func updateViewAttributes() {
        self.updateColors(self.viewModel.colors)

        self.labelView.text = self.viewModel.label
        self.labelView.font = self.viewModel.font.uiFont

        self.supplementaryLabelView.text = self.viewModel.supplementaryText
        self.supplementaryLabelView.font = self.viewModel.supplemetaryFont.uiFont
        self.alpha = self.viewModel.opacity
    }

    private func updateColors(_ colors: RadioButtonColors) {
        self.toggleView.setColors(colors)
        self.labelView.textColor = colors.label.uiColor
        self.labelView.textColor = colors.label.uiColor
        self.supplementaryLabelView.textColor = colors.subLabel.uiColor
    }

    private func setupButtonActions(isDisabled: Bool) {
        let actions: [(selector: Selector, event: UIControl.Event)] = [
            (#selector(actionTapped(sender:)), .touchUpInside),
            (#selector(actionTouchDown(sender:)), .touchDown),
            (#selector(actionTouchUp(sender:)), .touchUpOutside),
            (#selector(actionTouchUp(sender:)), .touchCancel)
        ]

        if isDisabled {
            for action in actions {
                self.button.removeTarget(self, action: action.selector, for: action.event)
            }
        } else {
            for action in actions {
                self.button.addTarget(self, action: action.selector, for: action.event)
            }
        }
    }

    private func setupConstraints() {
        let toggleViewWidthConstraint = self.toggleView.widthAnchor.constraint(equalToConstant: self.size)
        let toggleViewHeightConstraint = self.toggleView.heightAnchor.constraint(equalToConstant: self.size)
        let toggleViewSpacingConstraint = self.toggleView.trailingAnchor.constraint(equalTo: self.labelView.leadingAnchor, constant: -self.spacing)
        let labelViewTopConstraint = self.labelView.topAnchor.constraint(equalTo: self.toggleView.topAnchor, constant: self.textLabelTopSpacing)
        let toggleViewTopConstraint = self.toggleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.toggleViewPadding)
        let bottomViewConstraint = self.supplementaryLabelView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -(self.toggleViewPadding+self.textLabelTopSpacing))


        let constraints = [
            toggleViewWidthConstraint,
            toggleViewHeightConstraint,
            toggleViewSpacingConstraint,
            toggleViewTopConstraint,
            self.toggleView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),

            labelViewTopConstraint,
            self.labelView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            self.supplementaryLabelView.leadingAnchor.constraint(equalTo: self.labelView.leadingAnchor),
            self.supplementaryLabelView.trailingAnchor.constraint(equalTo: self.labelView.trailingAnchor),
            self.supplementaryLabelView.topAnchor.constraint(equalTo: self.labelView.bottomAnchor),
            bottomViewConstraint
        ]

        NSLayoutConstraint.activate(constraints)

        self.toggleViewWidthConstraint = toggleViewWidthConstraint
        self.toggleViewHeightConstraint = toggleViewHeightConstraint
        self.toggleViewSpacingConstraint = toggleViewSpacingConstraint
        self.labelViewTopConstraint = labelViewTopConstraint
        self.toggleViewTopConstraint = toggleViewTopConstraint
        self.labelViewBottomConstraint = bottomViewConstraint
    }

//    private func updateColors(colors: RadioButtonColorables) {
////        let radioButtonColors = self.viewModel.recalculateColors(selectedID: selectedID)
////        let radioButtonColors = self.viewModel.colors
//
//        self.toggleView.haloColor = colors.halo.uiColor
//        self.toggleView.buttonColor = colors.button.uiColor
//        self.toggleView.fillColor = colors.fill?.uiColor
//        self.labelView.textColor = colors.label.uiColor
//    }

    @IBAction func actionTapped(sender: UIButton)  {
        self.viewModel.setSelected()
//        self.updateColors(colors: self.viewModel.colors)

        self.toggleView.isPressed = false
    }

    @IBAction func actionTouchDown(sender: UIButton)  {
        self.toggleView.isPressed = true
    }

    @IBAction func actionTouchUp(sender: UIButton)  {
        self.toggleView.isPressed = false
    }
}

//MARK: - Private Helpers
private extension UILabel {
    static var standard: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true

        return label
    }
}

