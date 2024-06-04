//
//  SliderHandleUIControl.swift
//  SparkCore
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine
@_spi(SI_SPI) import SparkCommon
import SparkTheming

final class SliderHandleUIControl: UIControl {

    private let handleView = UIView()
    private let activeIndicatorView = UIView()

    private var cancellables = Set<AnyCancellable>()

    let viewModel: SliderHandleViewModel

    override var isHighlighted: Bool {
        didSet {
            self.activeIndicatorView.isHidden = !self.isHighlighted
        }
    }

    init(viewModel: SliderHandleViewModel) {
        self.viewModel = viewModel
        super.init(frame: .init(
            origin: .zero,
            size: .init(
                width: SliderConstants.handleSize.width,
                height: SliderConstants.handleSize.height
            )
        ))
        self.setupHandleView()
        self.setupActiveHandleView()
        self.subscribeToViewModelChanges()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHandleView() {
        self.handleView.frame = self.bounds
        self.handleView.isUserInteractionEnabled = false
        self.handleView.layer.cornerRadius = SliderConstants.handleSize.height / 2
        self.addSubview(self.handleView)
    }

    private func setupActiveHandleView() {
        self.activeIndicatorView.setBorderWidth(1.0)
        self.activeIndicatorView.isUserInteractionEnabled = false
        self.activeIndicatorView.isHidden = true
        self.activeIndicatorView.layer.cornerRadius = SliderConstants.activeIndicatorSize.height / 2

        self.activeIndicatorView.frame.size = .init(width: SliderConstants.activeIndicatorSize.width, height: SliderConstants.activeIndicatorSize.height)
        self.activeIndicatorView.center = self.handleView.center

        self.insertSubview(self.activeIndicatorView, belowSubview: self.handleView)
    }

    private func subscribeToViewModelChanges() {
        self.viewModel.$color.subscribe(in: &self.cancellables) { [weak self] newColor in
            guard let self else { return }
            self.handleView.backgroundColor = newColor.uiColor
            self.activeIndicatorView.setBorderColor(from: newColor)
        }
        self.viewModel.$activeIndicatorColor.subscribe(in: &self.cancellables) { [weak self] newActiveIndicatorColor in
            guard let self else { return }
            self.activeIndicatorView.backgroundColor = newActiveIndicatorColor.uiColor
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let beginTracking = super.beginTracking(touch, with: event)
        if let supercontrol = superview as? UIControl {
            return supercontrol.beginTracking(touch, with: event)
        }
        return beginTracking
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let continueTracking = super.continueTracking(touch, with: event)
        if let supercontrol = superview as? UIControl {
            return supercontrol.continueTracking(touch, with: event)
        }
        return continueTracking
    }

    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        if let supercontrol = superview as? UIControl {
            supercontrol.cancelTracking(with: event)
        }
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if let supercontrol = superview as? UIControl {
            supercontrol.endTracking(touch, with: event)
        }
    }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // CGColors need to be refreshed on trait changes
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.activeIndicatorView.setBorderColor(from: self.viewModel.color)
        }
    }
}
