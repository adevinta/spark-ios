//
//  PopoverViewController.swift
//  Spark
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import UIKit

/// ViewController used as a container for the content of a Popover
/// It handles the background configuration such as color, inner spacings and the drawing of the arrow if needed
/// The content viewController is defined by the consumer, it should have a .clear background, no padding and have a well defined preferredContentSize for the popover to calculate its size properly
public final class PopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    private let contentViewController: UIViewController
    private let viewModel: PopoverViewModel

    @ScaledUIMetric private var scaleFactor: CGFloat = 1.0

    init(viewModel: PopoverViewModel, contentViewController: UIViewController) {
        self.viewModel = viewModel
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self

        PopoverBackgroundConfiguration.showArrow = self.viewModel.showArrow
        PopoverBackgroundConfiguration.backgroundColor = self.viewModel.colors.background.uiColor
        PopoverBackgroundConfiguration.arrowSize = self.viewModel.arrowSize
        self.popoverPresentationController?.popoverBackgroundViewClass = PopoverBackgroundView.self
    }
    
    /// PopoverViewController initializer
    /// - Parameters:
    ///   - contentViewController: The viewController that will be embedded in the popover: it should have a .clear background, no padding and have a well defined preferredContentSize for the popover to calculate its size properly
    ///   - theme: The theme of a Popover
    ///   - intent: The intent of the Popover
    ///   - showArrow: Boolean used to show or hide the tip arrow of the Popover
    public convenience init(contentViewController: UIViewController, theme: Theme, intent: PopoverIntent, showArrow: Bool = true) {
        self.init(viewModel: .init(theme: theme, intent: intent, showArrow: showArrow), contentViewController: contentViewController)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.removeFromChild()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear

        self.contentViewController.willMove(toParent: self)
        let view: UIView = self.contentViewController.view
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)

        let leadingConstraint = view.leadingAnchor.constraint(
            greaterThanOrEqualTo: self.view.leadingAnchor,
            constant: self.viewModel.spaces.horizontal
        )
        leadingConstraint.priority = .required - 1
        let topConstraint = view.topAnchor.constraint(
            greaterThanOrEqualTo: self.view.topAnchor,
            constant: self.viewModel.spaces.vertical
        )
        topConstraint.priority = .required - 1
        NSLayoutConstraint.activate([
            leadingConstraint,
            topConstraint,
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])

        self.addChild(self.contentViewController)
        self.contentViewController.didMove(toParent: self)

    }

    private func removeFromChild() {
        self.contentViewController.willMove(toParent: nil)
        self.contentViewController.view?.removeFromSuperview()
        self.contentViewController.removeFromParent()
        self.contentViewController.didMove(toParent: nil)
    }

    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.preferredContentSize = self.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

