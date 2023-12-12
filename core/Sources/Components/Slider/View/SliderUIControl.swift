//
//  SliderUIControl.swift
//  SparkCore
//
//  Created by louis.borlee on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import Combine

public final class SliderUIControl: UIControl {

    private let viewModel: SingleSliderViewModel
    private var cancellables = Set<AnyCancellable>()
    private var _isTracking: Bool = false
    private var beginTrackingValue: Float = .zero

    // MARK: - Public properties
    /// The slider's current theme.
    public var theme: Theme {
        get { return self.viewModel.theme } 
        set { self.viewModel.theme = newValue }
    }
    
    /// The slider's current intent.
    public var intent: SliderIntent {
        get { return self.viewModel.intent }
        set { self.viewModel.intent = newValue }
    }
    
    /// The slider's current shape (`square` or `rounded`).
    public var shape: SliderShape {
        get { return self.viewModel.shape }
        set { self.viewModel.shape = newValue }
    }
    
    /// A Boolean value indicating whether changes in the slider’s value generate continuous update events.
    public var isContinuous: Bool {
        get { return self.viewModel.isContinuous }
        set { self.viewModel.isContinuous = newValue }
    }

    /// The minimum value of the slider.
    public var minimumValue: Float {
        get { return self.viewModel.minimumValue }
        set {
            self.viewModel.minimumValue = newValue
            self.setValue(self.value)
        }
    }
    
    /// The maximum value of the slider.
    public var maximumValue: Float {
        get { return self.viewModel.maximumValue }
        set {
            self.viewModel.maximumValue = newValue
            self.setValue(self.value)
        }
    }
    
    /// The distance between each valid value.
    public var steps: Float {
        get { return self.viewModel.steps }
        set { self.viewModel.steps = newValue }
    }

    public override var isEnabled: Bool {
        didSet {
            self.viewModel.isEnabled = self.isEnabled
            self.isUserInteractionEnabled = self.isEnabled
        }
    }

    /// The slider’s current value.
    public private(set) var value: Float = .zero {
        didSet {
            switch (self._isTracking, self.isContinuous) {
            case (false, _):
                break // valueChanged event should only trigger when isTracking is true same as UISlider
            case (true, false): // valueChanged event should not be sent while tracking when isContinuous is false
                break
            case (true, true):
                self.sendActions(for: .valueChanged)
            }
            self.setNeedsLayout()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            self.handle.isHighlighted = self.isHighlighted
        }
    }

    private var valueSubject = PassthroughSubject<Float, Never>()
    /// Value changes are sent to the publisher.
    /// Alternative: use addAction(UIAction, for: .valueChanged).
    public var valuePublisher: some Publisher<Float, Never> {
        return self.valueSubject
    }

    // MARK: - Subviews
    private let indicatorView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: SliderConstants.barHeight)))
    private let trackView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: SliderConstants.barHeight)))
    private let handle: SliderHandleUIControl

    init(viewModel: SingleSliderViewModel) {
        self.viewModel = viewModel
        self.handle = SliderHandleUIControl(
            viewModel: .init(color: viewModel.handleColor,
                             activeIndicatorColor: viewModel.handleActiveIndicatorColor)
        )
        super.init(frame: .init(origin: .zero, size: .init(width: 0, height: SliderConstants.handleSize.height)))
        self.alpha = self.viewModel.dim
        self.setupBar()
        self.subscribeToViewModel()
        self.translatesAutoresizingMaskIntoConstraints = false
        let defaultHeightConstraint = self.heightAnchor.constraint(equalToConstant: SliderConstants.handleSize.height)
        defaultHeightConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            defaultHeightConstraint
        ])
        self.addSubview(self.handle)
        self.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.valueSubject.send(self.value)
        }), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// SliderUIControler initializer
    /// - Parameters:
    ///   - theme: The slider's current theme
    ///   - shape: The slider's current shape (`square` or `rounded`)
    ///   - intent: The slider's current intent
    public convenience init(
        theme: Theme,
        shape: SliderShape,
        intent: SliderIntent
    ) {
        self.init(viewModel: .init(theme: theme, shape: shape, intent: intent))
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.indicatorView.center.y = self.frame.height / 2
        self.handle.center.y = self.frame.height / 2
        self.trackView.center.y = self.frame.height / 2

        let value = (max(self.minimumValue, self.value) - self.minimumValue) / (self.maximumValue - self.minimumValue)
        self.handle.center.x = (self.frame.width - SliderConstants.handleSize.width) * CGFloat(value) + SliderConstants.handleSize.width / 2

        self.indicatorView.frame.size.width = self.handle.center.x

        self.trackView.frame.origin.x = self.handle.center.x
        self.trackView.frame.size.width = self.frame.width - self.trackView.frame.origin.x
    }
    
    /// Sets the slider’s current value, allowing you to animate the change visually.
    /// - Parameters:
    ///   - value: The new value to assign to the value property
    ///   - animated: Specify `true` to animate the change in value; otherwise, specify `false` to update the slider’s appearance immediately. Animations are performed asynchronously and do not block the calling thread.
    public func setValue(_ value: Float, animated: Bool = false) {
        if animated {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else { return }
                self.viewModel.setAbsoluteValue(value)
                self.layoutSubviews()
            }
        } else {
            self.viewModel.setAbsoluteValue(value)
        }
    }

    private func setupBar() {
        self.indicatorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // Left
        self.addSubview(self.indicatorView)

        self.trackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner] // Right
        self.addSubview(self.trackView)
    }

    private func subscribeToViewModel() {
        // Indicator
        self.viewModel.$indicatorColor.subscribe(in: &self.cancellables) { [weak self] newIndicatorColor in
            self?.indicatorView.backgroundColor = newIndicatorColor.uiColor
        }
        self.viewModel.$indicatorRadius.subscribe(in: &self.cancellables) { [weak self] newIndicatorRadius in
            self?.indicatorView.layer.cornerRadius = newIndicatorRadius / 2.0 // "/ 2.0" for top / bottom
        }

        // Track
        self.viewModel.$trackColor.subscribe(in: &self.cancellables) { [weak self] newTrackColor in
            self?.trackView.backgroundColor = newTrackColor.uiColor
        }
        self.viewModel.$trackRadius.subscribe(in: &self.cancellables) { [weak self] newTrackRadius in
            self?.trackView.layer.cornerRadius = newTrackRadius / 2.0 // "/ 2.0" for top / bottom
        }

        // Handle
        self.viewModel.$handleColor.subscribe(in: &self.cancellables) { [weak self] newHandleColor in
            self?.handle.viewModel.color = newHandleColor
        }

        self.viewModel.$handleActiveIndicatorColor.subscribe(in: &self.cancellables) { [weak self] newHandleActiveIndicatorColor in
            self?.handle.viewModel.activeIndicatorColor = newHandleActiveIndicatorColor
        }

        // Value
        self.viewModel.$value.subscribe(in: &self.cancellables) { [weak self] newValue in
            guard let self,
                  self.value != newValue else { return }
            self.value = newValue
        }

        // Dim
        self.viewModel.$dim.subscribe(in: &self.cancellables) { [weak self] newDim in
            self?.alpha = newDim
        }
    }

    // MARK: - Tracking
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        self._isTracking = true
        let location = touch.location(in: self)
        self.beginTrackingValue = self.value
        self.isHighlighted = true
        self.moveHandle(to: location.x)
        return true
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let continueTracking = super.continueTracking(touch, with: event)

        let location = touch.location(in: self)

        self.moveHandle(to: location.x)

        return continueTracking
    }

    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if self._isTracking,
           self.isContinuous == false,
           self.value != self.beginTrackingValue {
            self.sendActions(for: .valueChanged)
        }
        self._isTracking = false
        self.isHighlighted = false
    }

    private func moveHandle(to: CGFloat) {
        let absoluteX = max(SliderConstants.handleSize.width / 2, min(to, self.frame.width - SliderConstants.handleSize.width / 2))
        let relativeX = (absoluteX - SliderConstants.handleSize.width / 2) / (self.frame.width - SliderConstants.handleSize.width)

        self.setValue(
            Float(relativeX) * (self.viewModel.maximumValue - self.viewModel.minimumValue) + self.viewModel.minimumValue,
            animated: false
        )
    }
}
